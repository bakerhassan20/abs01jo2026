<?php

namespace App\Http\Controllers;

use App\Filament\Resources\DropdownList\Model\DropdownList;
use App\Filament\Resources\TeamMember\Model\TeamMember;
use Illuminate\Support\Facades\Cache;

class TeamController extends Controller
{
    public function index($locale, $category)
    {
        $targetCategory = $this->findCategory($category);

        $data['category'] = $targetCategory;

        $data['members'] = Cache::rememberForever("team_" . $category . "_" . (new TeamMember())->getTable(), function () use ($targetCategory) {
            return TeamMember::active()
                ->with(['mainImage'])
                ->where('category_id', $targetCategory->id)
                ->get();
        });

        $data['featuredMembers'] = $data['members']->where('is_featured', true)->values();
        $data['otherMembers'] = $data['members']->where('is_featured', false)->values();

        return view('team.index', $data);
    }

    public function view($locale, $category, $slug)
    {
        $targetCategory = $this->findCategory($category);

        $targetItem = TeamMember::active()
            ->with(['mainImage'])
            ->where('category_id', $targetCategory->id)
            ->where('slug', $slug)
            ->first();

        if (! $targetItem) {
            abort(404);
        }

        return view('team.view', [
            'category' => $targetCategory,
            'targetItem' => $targetItem,
        ]);
    }

    private function findCategory($slug)
    {
        $targetCategory = DropdownList::activeWithCategory(DropdownList::TEAM_CATEGORY)
            ->where('slug', $slug)
            ->first();

        if (! $targetCategory) {
            abort(404);
        }

        return $targetCategory;
    }
}
