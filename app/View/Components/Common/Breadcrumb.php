<?php

namespace App\View\Components\Common;

use Illuminate\View\Component;

class Breadcrumb extends Component
{
    /**
     * The breadcrumb items.
     */
    public array $items;

    public function __construct(array $items = [])
    {
        $this->items = $items;
    }

    public function render()
    {
        return view('components.common.breadcrumb');
    }
}
