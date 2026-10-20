<?php

namespace App\Filament\Resources\TeamMember\Policy;

use App\Filament\Resources\TeamMember\Model\TeamMember;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class TeamMemberPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('view_any_team::member::team::member');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, TeamMember $teamMember): bool
    {
        return $user->can('view_team::member::team::member');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('create_team::member::team::member');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, TeamMember $teamMember): bool
    {
        return $user->can('update_team::member::team::member');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, TeamMember $teamMember): bool
    {
        return $user->can('delete_team::member::team::member');
    }

    /**
     * Determine whether the user can bulk delete models.
     */
    public function deleteAny(User $user): bool
    {
        return $user->can('delete_any_team::member::team::member');
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, TeamMember $teamMember): bool
    {
        return $user->can('force_delete_team::member::team::member');
    }

    /**
     * Determine whether the user can permanently bulk delete models.
     */
    public function forceDeleteAny(User $user): bool
    {
        return $user->can('force_delete_any_team::member::team::member');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, TeamMember $teamMember): bool
    {
        return $user->can('restore_team::member::team::member');
    }

    /**
     * Determine whether the user can bulk restore models.
     */
    public function restoreAny(User $user): bool
    {
        return $user->can('restore_any_team::member::team::member');
    }

    /**
     * Determine whether the user can replicate the model.
     */
    public function replicate(User $user, TeamMember $teamMember): bool
    {
        return $user->can('replicate_team::member::team::member');
    }

    /**
     * Determine whether the user can reorder models.
     */
    public function reorder(User $user): bool
    {
        return $user->can('reorder_team::member::team::member');
    }
}
