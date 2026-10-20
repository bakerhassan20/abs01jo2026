<?php

namespace App\Livewire;

use App\Filament\Resources\SubscribeWebform\Model\SubscribeWebform;

class SubscribeForm extends BaseForm
{
    public $mainModel = SubscribeWebform::class;


    public $subject = "Subscribe Form";
    public $emailList = "";


    public $email;

    public $mailData = [];

    public $exclude = ["id"];

    public $time = ["created_at"];


    public function setEmailList()
    {
        $this->emailList = setting("site.subscribe_email_list");
    }


    public function rules()
    {
        return
        [
            'email' => ['required', 'max:255', 'email:filter', 'unique:subscribe_webform,email', 'not_regex:/<[^b][^r][^>]*>/'],
        ];
    }

    public function render()
    {
        return view('livewire.subscribe-form');
    }
}
