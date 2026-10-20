<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * config/translatable.php has use_fallback = false, so empty Arabic fields render empty.
 * Copy the seeded English text into empty Arabic fields until the client provides the Arabic translation.
 */
return new class extends Migration
{
    public function up(): void
    {
        $tables = [
            'page_lang' => ['brief', 'content'],
            'bms_lang' => ['title', 'second_title', 'brief', 'content'],
            'school_lang' => ['brief', 'head_position', 'head_content', 'content'],
            'school_tab_lang' => ['content'],
            'school_subject_lang' => ['brief', 'content'],
            'team_member_lang' => ['position', 'brief', 'content'],
            'student_engagement_lang' => ['brief', 'content', 'list_title', 'list_content'],
            'dropdown_list_lang' => ['second_title', 'content'],
        ];

        foreach ($tables as $table => $columns) {
            foreach ($columns as $column) {
                DB::statement("
                    UPDATE {$table} ar
                    JOIN {$table} en ON en.parent_id = ar.parent_id AND en.language = 'en'
                    SET ar.{$column} = en.{$column}
                    WHERE ar.language = 'ar'
                      AND (ar.{$column} IS NULL OR ar.{$column} = '')
                      AND en.{$column} IS NOT NULL AND en.{$column} != ''
                ");
            }
        }
    }

    public function down(): void
    {
        // data migration, restore from the SQL dump instead
    }
};
