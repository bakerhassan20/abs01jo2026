<?php

namespace App\Filament\Resources\StudentEngagement\Policy;

use App\Filament\Resources\StudentEngagement\Model\StudentEngagement;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class StudentEngagementPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('view_any_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('view_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('create_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('update_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('delete_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can bulk delete models.
     */
    public function deleteAny(User $user): bool
    {
        return $user->can('delete_any_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('force_delete_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can permanently bulk delete models.
     */
    public function forceDeleteAny(User $user): bool
    {
        return $user->can('force_delete_any_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('restore_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can bulk restore models.
     */
    public function restoreAny(User $user): bool
    {
        return $user->can('restore_any_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can replicate the model.
     */
    public function replicate(User $user, StudentEngagement $studentEngagement): bool
    {
        return $user->can('replicate_student::engagement::student::engagement');
    }

    /**
     * Determine whether the user can reorder models.
     */
    public function reorder(User $user): bool
    {
        return $user->can('reorder_student::engagement::student::engagement');
    }
}
