<?php

namespace App\Livewire;

use App\Filament\Resources\AlumniStayConnectedWebform\Model\AlumniStayConnectedWebform;
use App\Filament\Resources\DropdownList\Model\DropdownList;
use Illuminate\Validation\Rule;

class AlumniStayConnectedForm extends BaseForm
{
    public $mainModel = AlumniStayConnectedWebform::class;


    public $subject = "Alumni Stay Connected Form";
    public $emailList = "";


    public $first_name, $middle_name, $last_name, $alumni_status, $email, $internation_phone_country = "JO", $mobile, $home_address,
        $is_alumni, $graduation_year, $current_profession, $universities_attended, $degrees_awarded, $listed_on_linkedin,
        $share_email, $is_parent, $spouse_is_alumni, $interested_activities, $receive_news, $suggestions;

    public $alumniStatusList = [];
    public $activitiesList = [];

    public $mailData = [];

    public $exclude = ["id"];

    public $time = ["created_at"];


    public function mount()
    {
        $this->alumniStatusList = DropdownList::activeWithCategory(DropdownList::ALUMNI_STATUS)->get()->pluck('title')->toArray();
        $this->activitiesList = DropdownList::activeWithCategory(DropdownList::ALUMNI_ACTIVITIES)->get()->pluck('title')->toArray();
    }


    public function setEmailList()
    {
        $this->emailList = setting("site.alumni_stay_connected_email_list");
    }


    public function rules()
    {
        $yesNo = ['nullable', Rule::in([__('site.YES'), __('site.NO')])];

        return
        [
            'first_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'middle_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'last_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'alumni_status' => ['nullable', Rule::in($this->alumniStatusList)],
            'email' => ['required', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/'],
            'internation_phone_country' => ['required'],
            'mobile' => ['required', 'phone:' . $this->internation_phone_country, 'regex:/^([0-9\s\-\+\(\)]*)$/', 'not_regex:/<[^b][^r][^>]*>/'],
            'home_address' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'is_alumni' => $yesNo,
            'graduation_year' => ['nullable', 'digits:4', 'integer', 'min:1981', 'max:' . date('Y')],
            'current_profession' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'universities_attended' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'degrees_awarded' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'listed_on_linkedin' => $yesNo,
            'share_email' => $yesNo,
            'is_parent' => $yesNo,
            'spouse_is_alumni' => $yesNo,
            'interested_activities' => ['nullable', Rule::in($this->activitiesList)],
            'receive_news' => $yesNo,
            'suggestions' => ['nullable', 'min:3', 'max:2000', 'not_regex:/<[^b][^r][^>]*>/'],
            'captcha' => ['required'],
        ];
    }

    public function render()
    {
        return view('livewire.alumni-stay-connected-form');
    }
}
