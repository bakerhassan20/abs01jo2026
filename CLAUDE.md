# ABS01JO2026: Claude reference (read before touching this project)

This is the Amman Baccalaureate School website. It is Laravel 10 + Filament 3, DOTJO Gen-2 skeleton, copied from `tan01jo2025` on 2026-10-20.

The company standard lives in `~/dotjo/company-ai-standard/CLAUDE.md`; follow it. This file records what was **already built here**, so the next step (integrating the front-end slicing) continues on the same structure.

## Current state

- **Backend: done.** Migrations, models, Filament resources, policies, permissions, webforms, settings, menus and seeded content are all in place.
- **Public controllers + routes: done and tested.** Every route returns 200 in `/en` and `/ar`.
- **Public views: unstyled placeholders.** Bare semantic HTML that prints every variable. **The next job is replacing their markup with the front-end developer's slicing.**

## Rules for integrating the slicing

1. **Do not change the controllers, routes, models or the DB** to fit the HTML. Adapt the HTML to the existing variables. Only add a query when the design shows data that no controller provides yet, and then follow the controller's existing style (`Cache::rememberForever`, `X::active()`, `Bms::activeWithCategory()`).
2. **Assets** go in `public/css`, `public/js`, `public/images` and `public/fonts`.
   - Include them in `resources/views/layouts/head.blade.php` (CSS) and `layouts/footer.blade.php` (JS) via `asset()`, with `nonce="{{ $cssNonce }}"` / `nonce="{{ $jsNonce }}"`.
   - No `@vite` on the public site. Page-specific files go in `@push('css')` / `@push('js')`.
3. **No hard-coded text.**
   - Fixed UI text: `__('site.UPPER_SNAKE_KEY')`. Add every new key, in en and ar, to the `message` / `message_lang` tables (category `site`, id 2) through a new data migration in the style of `2026_10_20_101300_insert_abs_initial_data.php` (`insertMessages`).
   - Content: always from the DB.
4. **No hard-coded URLs.** Use `route('name', ['locale' => $lng, ...])`. For admin-entered links use `{!! Utility::printAllUrl($url) !!}`. Settings links come from `setting('site.xxx')`.
5. **Images:** `<x-common.webp-image :mediaObject='$item->mainImage' alt='{{ $item->title }}' imgClass="..." />`. **Rich text:** `{!! Content::inlineStyleToClasses($item->content) !!}`.
6. **RTL** is already handled in `components/layouts/main-inner.blade.php`: `dir`, plus the `arabic-version` body class. Arabic CSS overrides hang off `.arabic-version`.
7. **Livewire forms** (`resources/views/livewire/*.blade.php`): restyle the markup, but keep every `wire:model="..."` name, `wire:submit="submit"`, the `@error` blocks, the success flash and `@include('livewire.partials.captcha')`.
   - Phone inputs: wire intl-tel-input to the hidden `internation_phone_country` field (ISO code, default `JO`).
8. **Every page view** wraps in `<x-layouts.layout seoTitle=... seoDescription=...>` + `@section('content')`. Page headers use `<x-common.header-image ... />`.
9. After integrating, smoke-test every route in `/en` and `/ar` (list below) and check `storage/logs/laravel.log`.

## Layout pieces (shared)

| File | Contents / data |
|---|---|
| `layouts/head.blade.php` | SEO component, CSS slot, `@livewireStyles` |
| `layouts/header.blade.php` | `$logo` (shared), language switch via `route('change-language', ['locale'=>$lng,'back'=>url()->full()])`, buttons from `setting('site.portal_url')`, `site.apply_now_url`, `site.calendar_url`, search link, `<x-common.general-menu />`, `<x-common.news-ticker />` |
| `components/common/general-menu.blade.php` | `$menuParents` (Menu `mega-menu`), `->childs`, up to 3 levels; `title`, `link` |
| `components/common/news-ticker.blade.php` | `$items` = Bms `news-ticker` (`title`, `url`) |
| `layouts/footer.blade.php` | logo, `__('site.FOOTER_SLOGAN')`, `<x-common.social-media-links />` (Buttons `social-media-links`), `<x-common.footer-menu />` (Menu `footer-menu`: parents are columns), contact settings (`{$lng}.site.location`, `site.main_phone`, `site.main_email`, `{$lng}.site.business_hours_from/_to`, `{$lng}.site.location_url`), `@livewire('subscribe-form')`, Enquire Now → `route('contact-us')`, `@livewireScripts`, `@stack('js')` |

## Page → view → variables

Figma frames are in file `f0QqcicdLzaQbHw0GY3UBu`, page "Final Design" (238:481).

| Page (Figma frame) | Route name / URL | View | Variables |
|---|---|---|---|
| HOME (477:4062) | `home` `/{lng}` | `site/home` | `$heroSlides` (Bms home-hero), `$whyAbs` (first = block, `url`), `$whyAbsFeatures`, `$factsFigures` (title=number, second_title=unit, brief=label), `$schools` (home-schools: title=grades, second_title=school, url), `$achievements` (title=value, brief=label), `$accreditations` (logo+url), `$latestNews` (News x4), `$testimonials` (brief=quote, title=name, second_title=role), `$notableAlumni`, `$universities` (featured) |
| School pages (738:3580, 738:4957, 524:20420) | `schools-view` `/schools/{slug}` (slugs: primary-school, middle-school, ib-college) | `schools/view` | `$targetItem`: title, grades_title, brief, content, head_title, head_name, head_position, head_content, mainImage, headImage, `->tabs` (title, content, mainImage, `->subjects`: title, brief = accordion body, content, mainImage, slug) |
| Subject detail (738:4099 Mathematics) | `schools-subject-view` `/schools/{schoolSlug}/{slug}` | `schools/subject` | `$school`, `$targetItem` (title, content, mainImage) |
| (schools list) | `schools-index` | `schools/index` | `$schools` |
| Board of Trustees (744:2126) / Senior Leadership (515:17346) | `team-index` `/team/{category}` (board-of-trustees, senior-leadership-team, staff) | `team/index` | `$category` (title, second_title = heading, content = intro), `$featuredMembers` (is_featured, e.g. the Chair), `$otherMembers`; member fields: title, position, brief, content, mainImage, slug |
| Member "Read More" | `team-view` `/team/{category}/{slug}` | `team/view` | `$category`, `$targetItem` (modal alternative: use `$member->content` on the index) |
| University Destinations | `universities-index` | `universities/index` | `$universities` (paginated: title, brief, url, mainImage) |
| Student Engagement landing (520:18159) | `student-engagement-index` | `student_engagement/index` | `$intro` (Bms student-engagement-intro), `$engagements` |
| Athletic and Recreation template (520:18913) | `student-engagement-view` `/student-engagement/{slug}` | `student_engagement/view` | `$intro`, `$targetItem` (content, mainImage, list_title, list_content, secondImage, `->albums` with `images`), `$moreEngagements` |
| Albums | `albums-index`, `albums-view` | `albums/*` | `$albums` (`images_count`), `$targetItem->images` |
| Tuition Fees (244:8539) | `tuition-fees-index` `/tuition-fees` | `tuition_fees/index` | `$taregtPage` (Page tuition-fees), `$registrationFees` (title, brief, second_title=amount), `$schools` with `->tuitionFees` (title=grade, amount), `$transportFees`, `$policies` |
| Alumni (768:4183) | `alumni-index` `/alumni` | `alumni/index` | `$taregtPage` (Page alumni), `$news` (alumni-news x3); links to stay-connected / class-note / giving |
| Alumni News (768:4858) | `alumni-news-index` `/alumni/news` | `alumni/news` | `$categories`, `$news` (paginated) |
| News | `news-index` `/news?category=slug`, `news-view` | `news/index`, `news/view` | `$news`, `$categories`, `$selectedCategory` / `$targetItem`, `$relatedNews` |
| Contact / Enquire | `contact-us` | `webforms/contact_us` → `livewire/contact-us-form` | `$subs` (Subjects) |
| Stay Connected (344:35504) | `alumni-stay-connected` | `webforms/alumni_stay_connected` → `livewire/alumni-stay-connected-form` | `$alumniStatusList`, `$activitiesList` |
| Class Note (248:18811) | `class-note` `/submit-a-class-note` | `webforms/class_note` → `livewire/class-note-form` | `$noteTypeList`, photo upload |
| Giving (343:34881) | `giving` | `webforms/giving` → `livewire/giving-form` | `$amountList`, `$designationList`, `$tributeList`, `$titleList`, `$donorTypeList` |
| Search | `search` | `site/search`, `site/search_ajax` | `$searchSections`, `$searchWord` |
| CMS pages | `page-view` `/{slug}` | `site/{page.view}` | `$taregtPage` (title, brief, content, mainImage, headerImage, seo), `$buttons`, `$sections` (Bms whose category = page slug), `$albums` (campus only) |

### CMS page templates (`Page::getViewList()`; the slug decides the data)

| Template view | Pages (slug) | `$sections` meaning |
|---|---|---|
| `site/letter` | letter-from-the-principal (242:7628), letter-from-the-chairman | — (brief = greeting, image = photo) |
| `site/guiding_statement` | guiding-statement (515:14548) | values (Bms `guiding-statement`) |
| `site/campus` | our-campus (244:9574) | + `$albums` with album category `our-campus` |
| `site/admissions_procedure` | admissions-procedure (242:6042) | steps (second_title = "STEP ONE", url, button_text_1) |
| `site/apply_now` | apply-now (244:8033) | tabs (title = tab, second_title = heading, content) |
| `site/development_department` | development-department (248:16409) | flipbook cards (title, image, url) |
| `site/employment` | employment (520:19643) | tabs: Employment / Opportunities / Living in Jordan |
| `site/page` | everything else (AEN 327:31163, shared-understanding, admissions, policies, privacy, terms…) | generic sections |

To give a CMS page a new design, add a template key to `Page::getViewList()` and create `resources/views/site/<key>.blade.php`. Then set the page's `view` column in a data migration.

## Admin-side map (where content is edited)

- **Modules:**
  - School, SchoolTab, SchoolSubject and TuitionFee (group "Schools").
  - TeamMember and University ("About Us").
  - StudentEngagement and Album ("Student Engagement").
  - News, which has a category: `school-news` / `alumni-news`.
- **Bms** (content blocks): category = DropdownList "Bms Category" slug. The category list is in `README.md`.
- **DropdownList categories** (constants in `DropdownList.php`): Team / News / Album Category, Alumni Status, Alumni Activities, Class Note Type, Giving Designation, Giving Tribute, Name Title, Donor Type, Subjects.
- **Webforms:** ContactUs, Subscribe, AlumniStayConnected, ClassNote and Giving (group "WebForms", list + export). Recipient emails come from `site.<form>_email_list` settings.
- **Settings page** `app/Filament/Pages/Settings/AllSetting.php` includes a "Header & External Links" section: portal, apply_now, calendar, book_tour, careers, tes_jobs.

## Conventions used here

- Generators used for the modules are kept in the session scratchpad. They are not part of the repo; new modules should copy `app/Filament/Resources/TeamMember/` (Pattern A) or `GivingWebform/` (Pattern B).
- Migrations:
  - Structure migrations: `2026_10_20_1000xx_create_<x>_tables.php`.
  - Data migrations: `2026_10_20_1013xx` – `1015xx`. They use `DB::table`, because `BaseModel` needs `Auth::user()`.
- Permissions: `<prefix>_<folder::model>` for modules (e.g. `view_any_team::member::team::member`), and flat `<prefix>_<x::webform>` for webforms. Inserted for `super_admin` in the initial data migration.
- `config/translatable.php` has `use_fallback => false`, so empty Arabic fields render empty. The English seed text was copied into empty Arabic fields (migration `101500`).
- The DB dump is `database/abs01jo2026.sql`. **Re-export it after any DB change**: `mysqldump --no-tablespaces --single-transaction --skip-dump-date abs01jo2026 > database/abs01jo2026.sql`. Truncate `session` and `audits` first.
- Local URL: Valet link `abs01jo2026` → `public/`. It needs `valet isolate php@8.3 --site=abs01jo2026` and `valet secure abs01jo2026`, which the user runs with sudo.

## Smoke-test URL list (prefix with /en and /ar)

`/`, `news`, `news/class-of-2026-achieves-record-ib-diploma-results`, `schools`, `schools/middle-school`, `schools/middle-school/middle-mathematics`, `schools/primary-school`, `schools/ib-college`, `team/board-of-trustees`, `team/senior-leadership-team`, `universities`, `student-engagement`, `student-engagement/athletic-and-recreation`, `albums`, `tuition-fees`, `alumni`, `alumni/news`, `contact-us`, `alumni-stay-connected`, `submit-a-class-note`, `giving`, `search?search_word=abs`, `site-map`, `letter-from-the-principal`, `guiding-statement`, `our-campus`, `admissions-procedure`, `apply-now`, `development-department`, `employment`, `additional-educational-needs`, `privacy-policy`, `terms-conditions`

Expected 404: `/xx/news`, `/en/schools/nope`, `/en/schools/primary-school/middle-mathematics` (a subject belonging to another school).

## Open items (not done yet)

- No images uploaded: logos, photos, accreditation and university logos.
- The client must fill reCAPTCHA keys (forms won't submit without them), SMTP, logo, form emails and header links.
- Arabic body text still has to be translated in the admin.
- Pages with no content yet: letter-from-the-chairman, strategic-priorities, innovation.
- Placeholders guessed from the design: Dima Qubain's position, and the empty bios/positions for Nour Masri and Fiyaz Ahmed.
- The admin login is the inherited `admin@dot.jo`; change its password.
- There is no git repository yet. Do not commit unless the user asks.
