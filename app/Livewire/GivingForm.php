<?php

namespace App\Livewire;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use Illuminate\Validation\Rule;
use App\Filament\Resources\GivingWebform\Model\GivingWebform;

class GivingForm extends BaseForm
{
    public $mainModel = GivingWebform::class;


    public $subject = "Giving Form";
    public $emailList = "";


    public $amount, $other_amount, $designation, $tribute, $on_behalf_of_organization = false, $organization_name, $title,
        $first_name, $last_name, $email, $internation_phone_country = "JO", $phone, $country, $address, $city, $state_zip,
        $is_anonymous = false, $appear_in_donor_report, $donor_type, $comment, $confirmation_email;

    public $amountList = ['100', '500', '1000', 'other'];
    public $designationList = [];
    public $tributeList = [];
    public $titleList = [];
    public $donorTypeList = [];

    public $mailData = [];

    public $exclude = ["id"];

    public $time = ["created_at"];


    public function mount()
    {
        $this->designationList = DropdownList::activeWithCategory(DropdownList::GIVING_DESIGNATION)->get()->pluck('title')->toArray();
        $this->tributeList = DropdownList::activeWithCategory(DropdownList::GIVING_TRIBUTE)->get()->pluck('title')->toArray();
        $this->titleList = DropdownList::activeWithCategory(DropdownList::NAME_TITLE)->get()->pluck('title')->toArray();
        $this->donorTypeList = DropdownList::activeWithCategory(DropdownList::DONOR_TYPE)->get()->pluck('title')->toArray();
    }


    public function setEmailList()
    {
        $this->emailList = setting("site.giving_email_list");
    }


    public function rules()
    {
        return
        [
            'amount' => ['required', Rule::in($this->amountList)],
            'other_amount' => ['required_if:amount,other', 'nullable', 'numeric', 'min:1', 'max:1000000'],
            'designation' => ['nullable', Rule::in($this->designationList)],
            'tribute' => ['nullable', Rule::in($this->tributeList)],
            'on_behalf_of_organization' => ['boolean'],
            'organization_name' => ['required_if:on_behalf_of_organization,true', 'nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'title' => ['required', Rule::in($this->titleList)],
            'first_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'last_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'email' => ['required', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/'],
            'internation_phone_country' => ['required'],
            'phone' => ['required', 'phone:' . $this->internation_phone_country, 'regex:/^([0-9\s\-\+\(\)]*)$/', 'not_regex:/<[^b][^r][^>]*>/'],
            'country' => ['required', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'address' => ['required', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'city' => ['required', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'state_zip' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'is_anonymous' => ['boolean'],
            'appear_in_donor_report' => ['nullable', Rule::in([__('site.YES'), __('site.NO')])],
            'donor_type' => ['required', Rule::in($this->donorTypeList)],
            'comment' => ['nullable', 'min:3', 'max:2000', 'not_regex:/<[^b][^r][^>]*>/'],
            'confirmation_email' => ['nullable', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/'],
            'captcha' => ['required'],
        ];
    }

    public function render()
    {
        return view('livewire.giving-form');
    }
}
