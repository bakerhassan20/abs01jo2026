<?php

namespace App\Livewire;

use App\Filament\Resources\ContactUsWebform\Model\ContactUsWebform;
use App\Filament\Resources\DropdownList\Model\DropdownList;

class ContactUsForm extends BaseForm
{
    public $mainModel = ContactUsWebform::class;


    public $subject = "Contact Us Form";
    public $emailList="";


    public $name, $email, $phone, $internation_phone_country = "JO", $department, $message, $company;
    public $subs=[];

    public $mailData = [];

    public $exclude = ["id"];

    public $time = ["created_at"];

    public $relation =
    [
        'reason_to_contact_id ' =>
        [
            "key" => "Resoan To Contact",
            "relation" => "reasonToContact",
            "relationTitle" => "title"
        ]

    ];


    public function mount()
    {

        $this->subs = DropdownList::activeWithCategory(DropdownList::SUBJECTS)
            ->get();
    }



    public function setEmailList()
    {
        $this->emailList = setting("site.contact_us_email_list");        
  
    }



    public function rules()
    {
        return
        [
            'name'    => [ 'required', 'min:3', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'email'   => [ 'required', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/' ],
            'internation_phone_country' => ['required'],
            'phone'    => ['required', 'phone:'.$this->internation_phone_country, 'regex:/^([0-9\s\-\+\(\)]*)$/', 'not_regex:/<[^b][^r][^>]*>/'],
            'department'   => [ 'required' ],
            'message' => [ 'nullable', 'min:3', 'max:255', 'not_regex:/<[^b][^r][^>]*>/' ],
            'company' => [ 'nullable', 'min:3', 'max:50', 'not_regex:/<[^b][^r][^>]*>/' ],
            'captcha' => ['required'],
        ];
    }

    public function render()
    {
        return view('livewire.contact-us-form');
    }
}
