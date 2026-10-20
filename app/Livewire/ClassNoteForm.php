<?php

namespace App\Livewire;

use App\Filament\Resources\ClassNoteWebform\Model\ClassNoteWebform;
use App\Filament\Resources\DropdownList\Model\DropdownList;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use Livewire\WithFileUploads;

class ClassNoteForm extends BaseForm
{
    use WithFileUploads;

    public $mainModel = ClassNoteWebform::class;


    public $subject = "Class Note Form";
    public $emailList = "";


    public $first_name, $last_name, $email, $graduation_year, $university, $field_of_study, $occupation, $location,
        $note_type, $note, $social_media_links, $confirmation_email, $photo, $share_permission;

    public $noteTypeList = [];

    public $mailData = [];

    public $exclude = ["id"];

    public $time = ["created_at"];

    public $fileAttributs = ['photo'];
    public $directoryName = 'class-notes';


    public function mount()
    {
        $this->noteTypeList = DropdownList::activeWithCategory(DropdownList::CLASS_NOTE_TYPE)->get()->pluck('title')->toArray();
    }


    public function setEmailList()
    {
        $this->emailList = setting("site.class_note_email_list");
    }


    // BaseForm uploads files from $this->form, this form keeps the photo in a public property
    public function uploadFilesIfExists($item)
    {
        if ($this->photo) {
            $filename = Str::random(6) . '_' . time() . '_' . $this->photo->getClientOriginalName();
            $this->photo = $this->photo->storeAs($this->directoryName, $filename, "public");
        }
    }


    public function rules()
    {
        return
        [
            'first_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'last_name' => ['required', 'min:2', 'max:255', 'regex:/^(?:[a-zA-Z ]+|[\p{Arabic} ]+)$/u', 'not_regex:/<[^b][^r][^>]*>/'],
            'email' => ['required', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/'],
            'graduation_year' => ['required', 'digits:4', 'integer', 'min:1981', 'max:' . date('Y')],
            'university' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'field_of_study' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'occupation' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'location' => ['required', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'note_type' => ['nullable', Rule::in($this->noteTypeList)],
            'note' => ['nullable', 'min:3', 'max:2000', 'not_regex:/<[^b][^r][^>]*>/'],
            'social_media_links' => ['nullable', 'max:255', 'not_regex:/<[^b][^r][^>]*>/'],
            'confirmation_email' => ['required', 'max:255', 'email:filter', 'not_regex:/<[^b][^r][^>]*>/'],
            'photo' => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:5120'],
            'share_permission' => ['accepted'],
            'captcha' => ['required'],
        ];
    }

    public function render()
    {
        return view('livewire.class-note-form');
    }
}
