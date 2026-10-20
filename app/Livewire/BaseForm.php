<?php

namespace App\Livewire;

use App\Classes\Utility;
use Livewire\Component;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Str;

class BaseForm extends Component
{
    public $mainModel;
    public $emailList;
    public $subject;
    public $mailData;

    public $exclude = [];
    public $time = [];
    public $relation = [];

    public $sendToKinz = false;
    public $kinzUrl="";
    private $kinzErrorMessage=[];


    public $fileAttributs;
    public $directoryName;



    public function updated($propertyName)
    {
        $this->validateOnly($propertyName);
    }


    public $captcha = null;

    public function updatedCaptcha($token)
    {
        $response = Http::post(
            'https://www.google.com/recaptcha/api/siteverify?secret='.
            setting("general.google_recaptcha_secret").
            '&response='.$token
        );

        $success = $response->json()['success'];

        if (!$success) {
            throw ValidationException::withMessages([
                'captcha' => __('site.Google thinks, you are a bot, please refresh and try again!'),
            ]);
        } else {
            $this->captcha = true;
        }
    }

    public function submit()
    {
        try
        {


            $this->validate();

            $this->uploadFilesIfExists($this);

            if ($this->sendToKinz && App::environment('prod') )
            {
                try
                {
                    if(!$this->integrateWithKinz())
                    {
                        throw new \Exception( json_encode($this->kinzErrorMessage) );
                    }
                }
                catch (\Exception $e)
                {
                    $this->addError('kinz', $e->getMessage());
                }
            }

            if(isset($this->form))
            {
                $item = $this->mainModel::create($this->form);
            }
            else
            {
                $item = $this->mainModel::create($this->all());
            }


            $this->prepareForEmail($item);

            Utility::sendEmailToAdmin($this->subject, $this->mailData, $this->emailList);



            session()->flash('success', __("site.SUBMITTED_SUCCESSFULLY") );

            if(isset($this->form))
            {
                $this->form = collect((new $this->mainModel)->rules())
                                ->keys()
                                ->mapWithKeys(fn($key) => [$key => null])
                                ->toArray();
                return $this->form;
            }
            else
            {
                $this->reset(array_keys($this->rulesExcept()));
            }
        }
        catch (\Exception $th)
        {
            throw $th;
            // dd($th->getMessage());
            // exit(); // EXIT_
        }

    }


    public function uploadFilesIfExists($item)
    {


        if(isset($this->fileAttributs) )
        {
            foreach($this->fileAttributs as $attributeName)
            {
                if (!empty($this->form[$attributeName] )) {
                    $filename = Str::random(6) . '_' . time() . '_' . $this->form[$attributeName]->getClientOriginalName();
                    $path = $this->form[$attributeName]->storeAs( $this->directoryName, $filename, "public" );
                    $this->form[$attributeName] = $path;
                }
                else{
                    $this->form[$attributeName] = null;
                    $this->fileAttributs = null;
                }

            }
        }

    }

    public function prepareForEmail($item)
    {
        $this->setEmailList();

        foreach($item->getAttributes() as $key => $loopItem)
        {
            if( in_array( $key, $this->exclude ))
            {
                continue;
            }
            if( in_array( $key, $this->time ))
            {
                // $this->mailData[ $key ] = date( "d/m/Y h:m" , $loopItem ) ;
                $this->mailData[ $key ] = $loopItem; //here we use timestap take it as it is
                continue;
            }
            if( $this->fileAttributs && in_array( $key, $this->fileAttributs ))
            {
                $this->mailData[$key] = "<a href='{$loopItem}'>{$key}</a>";;
                continue;
            }
            if( in_array( $key, array_keys($this->relation) ))
            {
                $currentRelation = $this->relation[$key]["relation"];
                $currentTitle = $this->relation[$key]["relationTitle"];
                if($item->$currentRelation){
                    $currentValue = $item->$currentRelation;
                    $currentValue = $currentValue->$currentTitle;
                    $this->mailData[ $this->relation[$key]["key"] ] = $currentValue;
                }


                continue;
            }
            $this->mailData[$key] = $loopItem;
        }

    }

    public function rulesExcept()
    {
        return $this->rules();
    }

    public function rules()
    {
        return collect((new $this->mainModel)->rules())
        ->mapWithKeys(fn($rules, $key) => ["form.$key" => $rules])
        ->toArray();
    }


    private function integrateWithKinz()
    {
        $data = $this->prepareToKinz();

        Utility::addApiLog($this->kinzUrl ."Request", $data, auth()->user());

        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_URL => $this->kinzUrl,
            CURLOPT_POST => 1,
            CURLOPT_HTTPAUTH => CURLAUTH_BASIC,
            CURLOPT_USERPWD => config('kinz.username') . ':' . config('kinz.password'),
            CURLOPT_POSTFIELDS => $data
        ));

        $response = curl_exec($curl);

        Utility::addApiLog($this->kinzUrl ."Response", $response, auth()->user());

        $response = json_decode($response);
        $valid=true;
        if($response->Status!='S200')
        {
            $valid=false;
            if($response->Status=='S410')
            {
                $this->kinzErrorMessage = ["error" => __('Kinz API authentication failed')];
            }
            else
            {
                $this->kinzErrorMessage = $response->Error;
            }
        }

        curl_close($curl);

        return $valid;

    }

    public function prepareToKinz(){}

}
