# ABS01JO2026: Amman Baccalaureate School website

This is a Laravel 10 + Filament 3 project built on the DOTJO Gen-2 CMS skeleton, copied from `tan01jo2025`. It is bilingual: `en` is the default and `ar` is RTL. The design source is the Figma file "ABS", page "Final Design".

The **backend is complete**. The public views in `resources/views` are **unstyled placeholders**: they output every variable, so the front-end developer can replace the markup with the slicing and keep the data bindings.

## Local setup

```bash
cp .env.example .env               # or copy a sibling .env, then set DB_DATABASE=abs01jo2026
mysql -u root -e "CREATE DATABASE abs01jo2026 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
mysql -u root abs01jo2026 < database/abs01jo2026.sql
composer install && php artisan key:generate && php artisan storage:link
php artisan serve                  # site: /en  /ar   admin: /admin
```

The SQL dump already contains every migration in `database/migrations`.

## Settings to fill in (Admin → All Setting)

- **Site:** logo, favicon, default header image.
- **reCAPTCHA:** site key and secret. Every public form except Subscribe requires them.
- **SMTP.**
- **Webform email lists:**
  - `site.contact_us_email_list`
  - `site.subscribe_email_list`
  - `site.alumni_stay_connected_email_list`
  - `site.class_note_email_list`
  - `site.giving_email_list`
- **Header & external links:**
  - ABS Portal, Apply Now, Calendar, Book a Tour
  - Careers page, Tes Jobs
- **Social media links:** Button category `social-media-links`.

## Modules (`app/Filament/Resources`)

| Module | Table | Public route |
|---|---|---|
| School | `school` (+`_lang`) | `schools-index` `/schools`, `schools-view` `/schools/{slug}` |
| SchoolTab (tabs on a school page) | `school_tab` | shown inside `schools-view` |
| SchoolSubject (accordion items in a tab) | `school_subject` | `schools-subject-view` `/schools/{school}/{slug}` |
| TuitionFee (grade fees per school) | `tuition_fee` | `tuition-fees-index` `/tuition-fees` |
| TeamMember (category = DropdownList "Team Category") | `team_member` | `team-index` `/team/{category}`, `team-view` `/team/{category}/{slug}` |
| University | `university` | `universities-index` `/universities` (featured ones appear on home) |
| StudentEngagement | `student_engagement` | `student-engagement-index`, `student-engagement-view` `/student-engagement/{slug}` |
| Album (+ `album_image` pivot) | `album` | `albums-index`, `albums-view` `/albums/{slug}` |
| News (now with `category_id`) | `news` | `news-index` `/news?category=`, `news-view`, `alumni-news-index` `/alumni/news` |

Team categories: `board-of-trustees`, `senior-leadership-team`, `staff`.

### Webforms (Livewire `BaseForm`, admin list + export)

| Form | Table | Page |
|---|---|---|
| ContactUsForm (Enquire Now / Book a Tour) | `contact_us_webform` | `contact-us` |
| SubscribeForm (footer) | `subscribe_webform` | footer, every page |
| AlumniStayConnectedForm | `alumni_stay_connected_webform` | `alumni-stay-connected` |
| ClassNoteForm (photo upload to `storage/app/public/class-notes`) | `class_note_webform` | `class-note` |
| GivingForm | `giving_webform` | `giving` |

## Content blocks

Bms categories are Dropdown List rows with category "Bms Category".

| Bms category | Used on |
|---|---|
| `news-ticker` | header ticker, every page |
| `home-hero`, `why-abs`, `why-abs-features`, `facts-figures`, `home-schools`, `academic-achievements`, `accreditations`, `testimonials`, `notable-alumni` | home |
| `student-engagement-intro` | student engagement pages |
| `tuition-registration-fees`, `tuition-transport`, `tuition-policies` | tuition fees |
| **`<page-slug>`** | sections of a CMS page (`SiteController::index` passes them as `$sections`) |

The `<page-slug>` categories currently in use are `admissions-procedure` (steps), `apply-now` (tabs), `guiding-statement` (values), `development-department` (flipbooks) and `employment` (tabs).

The CMS Page templates (`Page::getViewList()` → `resources/views/site/*`) are `page`, `letter`, `guiding_statement`, `campus`, `admissions_procedure`, `apply_now`, `development_department` and `employment`.

Menus: `mega-menu` (header), `footer-menu` (Schools + Quick Links columns) and `site-map-menu`.

UI strings use `__('site.KEY')`. They are stored in the DB (Admin → Message Category → site) in en and ar.

## Notes for the front-end developer

- Put the slicing CSS/JS in `public/css` and `public/js`. Include them in `layouts/head.blade.php` and `layouts/footer.blade.php` with `nonce="{{ $cssNonce }}"` / `nonce="{{ $jsNonce }}"`.
- Keep the `wire:model` names in `resources/views/livewire/*`.
- Phone fields post `internation_phone_country` (default `JO`). Wire intl-tel-input to that field.
- The design only had English body text. Migration `2026_10_20_101500` copied the English text into the empty Arabic fields, because `config/translatable.php` has `use_fallback => false`. Translate those fields in the admin; titles are already in Arabic.
