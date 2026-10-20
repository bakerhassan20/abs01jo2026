<?php

namespace App\Filament\Resources\University\Policy;

use App\Filament\Resources\University\Model\University;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class UniversityPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('view_any_university::university');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, University $university): bool
    {
        return $user->can('view_university::university');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('create_university::university');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, University $university): bool
    {
        return $user->can('update_university::university');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, University $university): bool
    {
        return $user->can('delete_university::university');
    }

    /**
     * Determine whether the user can bulk delete models.
     */
    public function deleteAny(User $user): bool
    {
        return $user->can('delete_any_university::university');
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, University $university): bool
    {
        return $user->can('force_delete_university::university');
    }

    /**
     * Determine whether the user can permanently bulk delete models.
     */
    public function forceDeleteAny(User $user): bool
    {
        return $user->can('force_delete_any_university::university');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, University $university): bool
    {
        return $user->can('restore_university::university');
    }

    /**
     * Determine whether the user can bulk restore models.
     */
    public function restoreAny(User $user): bool
    {
        return $user->can('restore_any_university::university');
    }

    /**
     * Determine whether the user can replicate the model.
     */
    public function replicate(User $user, University $university): bool
    {
        return $user->can('replicate_university::university');
    }

    /**
     * Determine whether the user can reorder models.
     */
    public function reorder(User $user): bool
    {
        return $user->can('reorder_university::university');
    }
}
