<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * Lookups, Bms categories, CMS pages, menus, permissions and UI translations required by the ABS website.
 */
return new class extends Migration
{
    private $now;
    private $userId = 1;

    public function up(): void
    {
        $this->now = time();

        $this->insertDropdownLists();
        $this->insertPages();
        $this->insertMenus();
        $this->insertPermissions();
        $this->insertMessages();
    }

    public function down(): void
    {
        // data migration, restore from the SQL dump instead
    }


    private function insertTranslated(string $table, array $row, array $translations, bool $blame = true): int
    {
        if ($blame) {
            $row += [
                'created_at' => $this->now,
                'updated_at' => $this->now,
                'created_by' => $this->userId,
                'updated_by' => $this->userId,
            ];
        }

        $id = DB::table($table)->insertGetId($row);

        foreach ($translations as $language => $attributes) {
            DB::table($table . '_lang')->insert(['parent_id' => $id, 'language' => $language] + $attributes);
        }

        return $id;
    }

    private function dropdown(string $category, string $slug, string $en, string $ar, int $order = 10, array $enExtra = [], array $arExtra = []): int
    {
        return $this->insertTranslated('dropdown_list', [
            'slug' => $slug,
            'status' => 1,
            'category' => $category,
            'published_at' => $this->now,
            'weight_order' => $order,
        ], [
            'en' => ['title' => $en] + $enExtra,
            'ar' => ['title' => $ar] + $arExtra,
        ]);
    }


    private function insertDropdownLists(): void
    {
        // Bms categories (slug is used by the controllers / page templates)
        $bmsCategories = [
            'news-ticker' => ['Header News Ticker', 'شريط الأخبار'],
            'home-hero' => ['Home Hero', 'واجهة الصفحة الرئيسية'],
            'why-abs' => ['Home - Why ABS', 'الرئيسية - لماذا ABS'],
            'why-abs-features' => ['Home - Why ABS Features', 'الرئيسية - مميزات ABS'],
            'facts-figures' => ['Home - Facts & Figures', 'الرئيسية - حقائق وأرقام'],
            'home-schools' => ['Home - Schools Cards', 'الرئيسية - بطاقات المدارس'],
            'academic-achievements' => ['Home - Academic Achievements', 'الرئيسية - الإنجازات الأكاديمية'],
            'accreditations' => ['Home - Accreditations & Recognitions', 'الرئيسية - الاعتمادات'],
            'testimonials' => ['Home - Voices of ABS', 'الرئيسية - آراء مجتمع ABS'],
            'notable-alumni' => ['Home - Notable Alumni', 'الرئيسية - خريجون متميزون'],
            'student-engagement-intro' => ['Student Engagement Intro', 'مقدمة الأنشطة الطلابية'],
            'tuition-registration-fees' => ['Tuition - Initial Registration Fees', 'الرسوم - رسوم التسجيل'],
            'tuition-transport' => ['Tuition - Transport Fees', 'الرسوم - رسوم المواصلات'],
            'tuition-policies' => ['Tuition - Payment & Withdrawal Policies', 'الرسوم - سياسات الدفع والانسحاب'],
            'admissions-procedure' => ['Page - Admissions Procedure Steps', 'صفحة - خطوات القبول'],
            'apply-now' => ['Page - Apply Now Tabs', 'صفحة - تبويبات التقديم'],
            'guiding-statement' => ['Page - Guiding Statement Values', 'صفحة - القيم'],
            'development-department' => ['Page - Development Department Cards', 'صفحة - بطاقات دائرة التطوير'],
            'employment' => ['Page - Employment Tabs', 'صفحة - تبويبات التوظيف'],
        ];
        $order = 10;
        foreach ($bmsCategories as $slug => [$en, $ar]) {
            $this->dropdown('Bms Category', $slug, $en, $ar, $order++);
        }

        // Team categories: second_title = section heading, content = intro
        $this->dropdown('Team Category', 'board-of-trustees', 'Board of Trustees', 'مجلس الأمناء', 1,
            ['second_title' => 'Leadership', 'content' => '<p>Guiding our vision with expertise, dedication, and a shared commitment to academic excellence since 1981.</p>'],
            ['second_title' => 'القيادة', 'content' => '<p>نوجّه رؤيتنا بالخبرة والتفاني والالتزام المشترك بالتميّز الأكاديمي منذ عام 1981.</p>']);
        $this->dropdown('Team Category', 'senior-leadership-team', 'Senior Leadership Team', 'فريق القيادة العليا', 2,
            ['second_title' => 'Executive Leadership', 'content' => '<p>Driving academic excellence, innovation, and holistic student success across the Amman Baccalaureate School community.</p>'],
            ['second_title' => 'القيادة التنفيذية', 'content' => '<p>نقود التميّز الأكاديمي والابتكار والنجاح الشامل للطلبة في مجتمع مدرسة البكالوريا - عمان.</p>']);
        $this->dropdown('Team Category', 'staff', 'Staff', 'الكادر', 3);

        // News categories
        $this->dropdown('News Category', 'school-news', 'School News', 'أخبار المدرسة', 1);
        $this->dropdown('News Category', 'alumni-news', 'Alumni News', 'أخبار الخريجين', 2);

        // Album categories (slug "our-campus" lists albums on the Our Campus page)
        $this->dropdown('Album Category', 'our-campus', 'Our Campus', 'حرمنا المدرسي', 1);
        $this->dropdown('Album Category', 'student-engagement', 'Student Engagement', 'الأنشطة الطلابية', 2);

        // Contact us subjects
        $this->dropdown('Subjects', 'general-enquiry', 'General Enquiry', 'استفسار عام', 1);
        $this->dropdown('Subjects', 'admissions', 'Admissions', 'القبول', 2);
        $this->dropdown('Subjects', 'book-a-tour', 'Book a Tour', 'حجز جولة', 3);

        // Webform lookups
        $lookups = [
            'Alumni Status' => [['Alumnus / Alumna', 'خريج / خريجة'], ['Former Student', 'طالب سابق'], ['Friend of ABS', 'صديق المدرسة']],
            'Alumni Activities' => [['Reunions', 'لقاءات الخريجين'], ['Mentoring Students', 'إرشاد الطلبة'], ['Career Talks', 'محاضرات مهنية'], ['Volunteering', 'التطوع']],
            'Class Note Type' => [['Career Update', 'تحديث مهني'], ['Education Update', 'تحديث تعليمي'], ['Family News', 'أخبار عائلية'], ['Achievement / Award', 'إنجاز / جائزة'], ['Other', 'أخرى']],
            'Giving Designation' => [['Where Most Needed', 'حيث الحاجة الأكبر'], ['Scholarships & Bursaries', 'المنح الدراسية'], ['Campus Development', 'تطوير الحرم المدرسي'], ['Arts & Athletics', 'الفنون والرياضة']],
            'Giving Tribute' => [['None', 'لا يوجد'], ['In Honor Of', 'تكريماً لـ'], ['In Memory Of', 'إحياءً لذكرى']],
            'Name Title' => [['Mr', 'السيد'], ['Mrs', 'السيدة'], ['Ms', 'الآنسة'], ['Dr', 'الدكتور']],
            'Donor Type' => [['Alumnus / Alumna', 'خريج / خريجة'], ['Parent', 'ولي أمر'], ['Grandparent', 'جد / جدة'], ['Staff', 'موظف'], ['Friend of ABS', 'صديق المدرسة']],
        ];
        foreach ($lookups as $category => $items) {
            foreach ($items as $index => [$en, $ar]) {
                $slug = \Illuminate\Support\Str::slug($category . ' ' . $en);
                $this->dropdown($category, $slug, $en, $ar, $index + 1);
            }
        }
    }


    private function insertPages(): void
    {
        $pages = [
            // slug => [view, en title, ar title, en brief]
            'letter-from-the-chairman' => ['letter', 'Letter from the Chairman', 'رسالة رئيس مجلس الأمناء', null],
            'letter-from-the-principal' => ['letter', 'Letter from the School Principal & CEO', 'رسالة مديرة المدرسة والرئيسة التنفيذية', 'Welcome to ABS'],
            'guiding-statement' => ['guiding_statement', 'Guiding Statement - Who We Are', 'البيان التوجيهي - من نحن', null],
            'shared-understanding-of-high-quality-learning' => ['page', 'ABS Shared Understanding of High-Quality Learning', 'الفهم المشترك للتعلّم عالي الجودة', null],
            'strategic-priorities' => ['page', 'Strategic Priorities', 'الأولويات الاستراتيجية', null],
            'innovation' => ['page', 'Innovation', 'الابتكار', null],
            'our-campus' => ['campus', 'Our Campus', 'حرمنا المدرسي', null],
            'admissions' => ['page', 'Admissions', 'القبول', null],
            'admissions-procedure' => ['admissions_procedure', 'Admissions Procedure', 'إجراءات القبول', 'Prospective Parents'],
            'tuition-fees' => ['page', 'Tuition Fees', 'الرسوم الدراسية', 'Financial Information'],
            'apply-now' => ['apply_now', 'Admission Applications', 'طلبات القبول', null],
            'admission-policy' => ['page', 'Admission Policy', 'سياسة القبول', null],
            'examination-entry-policy' => ['page', 'Examination Entry Policy', 'سياسة التقدم للامتحانات', null],
            'scholarships-bursaries-and-awards' => ['page', 'Scholarships, Bursaries and Awards', 'المنح الدراسية والجوائز', null],
            'additional-educational-needs' => ['page', 'Additional Educational Needs (AEN)', 'الاحتياجات التعليمية الإضافية', 'Access and Inclusion at ABS'],
            'development-department' => ['development_department', 'Development Department', 'دائرة التطوير', 'Welcome to the Office of Development!'],
            'alumni' => ['page', 'Alumni', 'الخريجون', null],
            'employment' => ['employment', 'Employment', 'التوظيف', null],
            'privacy-policy' => ['page', 'Privacy Policy', 'سياسة الخصوصية', null],
            'terms-conditions' => ['page', 'Terms and Conditions', 'الشروط والأحكام', null],
            'site-map' => ['page', 'Site Map', 'خريطة الموقع', null],
        ];

        $order = 10;
        foreach ($pages as $slug => [$view, $en, $ar, $brief]) {
            $this->insertTranslated('page', [
                'slug' => $slug,
                'status' => 1,
                'view' => $view,
                'layout' => 'main',
                'published_at' => $this->now,
                'weight_order' => $order++,
            ], [
                'en' => ['title' => $en, 'brief' => $brief],
                'ar' => ['title' => $ar],
            ]);
        }
    }


    private function menuLink(int $menuId, int $parentId, int $order, string $en, string $ar, ?string $link): int
    {
        return $this->insertTranslated('menu_link', [
            'menu_id' => $menuId,
            'self_parent_id' => $parentId,
            'custom_color_class' => '',
            'order' => $order,
            'weight_order' => $order,
            'status' => 1,
            'published_at' => $this->now,
        ], [
            'en' => ['title' => $en, 'link' => $link],
            'ar' => ['title' => $ar, 'link' => $link],
        ]);
    }

    private function insertMenus(): void
    {
        $megaMenu = DB::table('menu')->where('category_slug', 'mega-menu')->value('id');
        $footerMenu = DB::table('menu')->where('category_slug', 'footer-menu')->value('id');
        $siteMapMenu = DB::table('menu')->where('category_slug', 'site-map-menu')->value('id');

        $tree = [
            ['About Us', 'من نحن', null, [
                ['Letter from the Chairman', 'رسالة رئيس مجلس الأمناء', '/letter-from-the-chairman'],
                ['Letter from the School Principal and CEO', 'رسالة مديرة المدرسة', '/letter-from-the-principal'],
                ['Guiding Statement - Who We Are', 'البيان التوجيهي - من نحن', '/guiding-statement'],
                ['ABS Shared Understanding of High-Quality Learning', 'الفهم المشترك للتعلّم عالي الجودة', '/shared-understanding-of-high-quality-learning'],
                ['Strategic Priorities', 'الأولويات الاستراتيجية', '/strategic-priorities'],
                ['Board of Trustees', 'مجلس الأمناء', '/team/board-of-trustees'],
                ['Innovation', 'الابتكار', '/innovation'],
                ['Senior Leadership Team', 'فريق القيادة العليا', '/team/senior-leadership-team'],
                ['Staff', 'الكادر', '/team/staff'],
                ['Our Campus', 'حرمنا المدرسي', '/our-campus'],
            ]],
            ['Schools', 'المدارس', null, [
                ['Primary School – KG1 - Grade 6', 'المدرسة الابتدائية – الروضة الأولى - الصف السادس', '/schools/primary-school'],
                ['Secondary School – Middle School (Grades 7-10)', 'المدرسة الثانوية – المرحلة المتوسطة (7-10)', '/schools/middle-school'],
                ['Secondary School – IB College (Grades 11-12)', 'المدرسة الثانوية – كلية البكالوريا الدولية (11-12)', '/schools/ib-college'],
            ]],
            ['Admissions', 'القبول', null, [
                ['Overview', 'نظرة عامة', '/admissions'],
                ['Admissions Procedure', 'إجراءات القبول', '/admissions-procedure'],
                ['Tuition Fees', 'الرسوم الدراسية', '/tuition-fees'],
                ['Apply Now', 'قدّم الآن', '/apply-now'],
                ['Admission Policy', 'سياسة القبول', '/admission-policy'],
                ['Examination Entry Policy', 'سياسة التقدم للامتحانات', '/examination-entry-policy'],
                ['Scholarships, Bursaries and Awards', 'المنح الدراسية والجوائز', '/scholarships-bursaries-and-awards'],
            ]],
            ['Student Engagement', 'الأنشطة الطلابية', null, [
                ['Overview', 'نظرة عامة', '/student-engagement'],
                ['Athletic and Recreation', 'الرياضة والترفيه', '/student-engagement/athletic-and-recreation'],
                ['Extra Co-Curricular Activities and CAS', 'الأنشطة اللامنهجية و CAS', '/student-engagement/extra-co-curricular-activities-and-cas'],
                ['Adventure and Leadership', 'المغامرة والقيادة', '/student-engagement/adventure-and-leadership'],
                ['Arts and Culture', 'الفنون والثقافة', '/student-engagement/arts-and-culture'],
                ['Academic Enrichment', 'الإثراء الأكاديمي', '/student-engagement/academic-enrichment'],
                ['Additional Educational Needs (AEN)', 'الاحتياجات التعليمية الإضافية', '/additional-educational-needs'],
            ]],
            ['School Development', 'تطوير المدرسة', null, [
                ['Alumni', 'الخريجون', '/alumni'],
                ['Alumni - Stay Connected Form', 'نموذج تواصل الخريجين', '/alumni-stay-connected'],
                ['Development Department', 'دائرة التطوير', '/development-department'],
                ['Giving Page Form', 'نموذج العطاء', '/giving'],
                ['Submit a Class Note Form', 'نموذج ملاحظة الدفعة', '/submit-a-class-note'],
            ]],
            ['Employment', 'التوظيف', '/employment', []],
        ];

        foreach ([$megaMenu, $siteMapMenu] as $menuId) {
            if (! $menuId) {
                continue;
            }
            foreach ($tree as $parentOrder => [$en, $ar, $link, $children]) {
                $parentId = $this->menuLink($menuId, -1, $parentOrder + 1, $en, $ar, $link);
                foreach ($children as $childOrder => [$childEn, $childAr, $childLink]) {
                    $this->menuLink($menuId, $parentId, $childOrder + 1, $childEn, $childAr, $childLink);
                }
            }
        }

        if ($footerMenu) {
            $schools = $this->menuLink($footerMenu, -1, 1, 'Schools', 'المدارس', null);
            $this->menuLink($footerMenu, $schools, 1, 'Primary School - KG1 - Grade 6', 'المدرسة الابتدائية', '/schools/primary-school');
            $this->menuLink($footerMenu, $schools, 2, 'Secondary School - Middle School (Grades 7-10)', 'المرحلة المتوسطة', '/schools/middle-school');
            $this->menuLink($footerMenu, $schools, 3, 'Secondary School - IB College (Grades 11-12)', 'كلية البكالوريا الدولية', '/schools/ib-college');

            $quickLinks = $this->menuLink($footerMenu, -1, 2, 'Quick Links', 'روابط سريعة', null);
            $this->menuLink($footerMenu, $quickLinks, 1, 'Why ABS', 'لماذا ABS', '/guiding-statement');
            $this->menuLink($footerMenu, $quickLinks, 2, 'Letter from the Chairman', 'رسالة رئيس مجلس الأمناء', '/letter-from-the-chairman');
            $this->menuLink($footerMenu, $quickLinks, 3, 'Our Campus', 'حرمنا المدرسي', '/our-campus');
            $this->menuLink($footerMenu, $quickLinks, 4, 'Book a Tour', 'احجز جولة', '/contact-us');
            $this->menuLink($footerMenu, $quickLinks, 5, 'Alumni', 'الخريجون', '/alumni');
            $this->menuLink($footerMenu, $quickLinks, 6, 'Working at ABS', 'العمل في ABS', '/employment');
        }
    }


    private function insertPermissions(): void
    {
        $prefixes = ['view', 'view_any', 'create', 'update', 'restore', 'restore_any', 'replicate', 'reorder', 'delete', 'delete_any', 'force_delete', 'force_delete_any', 'import', 'export'];

        $identifiers = [
            'school::school',
            'school::tab::school::tab',
            'school::subject::school::subject',
            'tuition::fee::tuition::fee',
            'team::member::team::member',
            'university::university',
            'student::engagement::student::engagement',
            'album::album',
            'subscribe::webform',
            'alumni::stay::connected::webform',
            'class::note::webform',
            'giving::webform',
        ];

        $superAdmin = DB::table('roles')->where('name', 'super_admin')->value('id');
        $date = date('Y-m-d H:i:s', $this->now);

        foreach ($identifiers as $identifier) {
            foreach ($prefixes as $prefix) {
                $name = $prefix . '_' . $identifier;
                if (DB::table('permissions')->where('name', $name)->exists()) {
                    continue;
                }
                $permissionId = DB::table('permissions')->insertGetId([
                    'name' => $name,
                    'guard_name' => 'web',
                    'created_at' => $date,
                    'updated_at' => $date,
                ]);
                if ($superAdmin) {
                    DB::table('role_has_permissions')->insert(['permission_id' => $permissionId, 'role_id' => $superAdmin]);
                }
            }
        }
    }


    private function insertMessages(): void
    {
        $categoryId = DB::table('message_category')->where('title', 'site')->value('id');

        $messages = [
            'ABS_CAREERS_PAGE' => ['Amman Baccalaureate School (ABS) Careers Page', 'صفحة الوظائف في مدرسة البكالوريا - عمان'],
            'ABS_FACTS_FIGURES' => ['ABS Facts & Figures', 'حقائق وأرقام عن ABS'],
            'ABS_LISTED_ON_LINKEDIN' => ['Do you have ABS listed as your school on your LinkedIn profile?', 'هل أدرجت ABS كمدرستك في ملفك على LinkedIn؟'],
            'ABS_PORTAL' => ['ABS Portal', 'بوابة ABS'],
            'ABS_TES_JOBS' => ['Amman Baccalaureate School - Tes Jobs', 'مدرسة البكالوريا - عمان - وظائف Tes'],
            'ACADEMIC_ACHIEVEMENTS' => ['Academic Achievements & Success', 'الإنجازات الأكاديمية والنجاح'],
            'ACADEMIC_ACHIEVEMENTS_BRIEF' => ['Outstanding academic results and a culture of principled learning have defined the ABS experience since 1981.', 'نتائج أكاديمية متميزة وثقافة تعلّم قائمة على المبادئ ميّزت تجربة ABS منذ عام 1981.'],
            'ACCREDITATIONS_RECOGNITIONS' => ['Accreditations & Recognitions', 'الاعتمادات والتقديرات'],
            'ACCREDITATIONS_RECOGNITIONS_BRIEF' => ['Proudly authorized, licensed, and partnered with leading international educational institutions and global frameworks.', 'معتمدون ومرخّصون بفخر وشركاء لمؤسسات تعليمية دولية رائدة وأطر عالمية.'],
            'ADDRESS' => ['Address', 'العنوان'],
            'ALBUMS' => ['Albums', 'الألبومات'],
            'ALL' => ['All', 'الكل'],
            'ALL_RIGHTS_RESERVED' => ['All rights reserved.', 'جميع الحقوق محفوظة.'],
            'ALUMNI' => ['Alumni', 'الخريجون'],
            'ALUMNI_NEWS' => ['Alumni News', 'أخبار الخريجين'],
            'AMOUNT_JOD' => ['Amount JOD', 'المبلغ بالدينار'],
            'ANNUAL_TUITION_FEES' => ['Annual Tuition Fees', 'الرسوم الدراسية السنوية'],
            'ANNUAL_TUITION_FEES_BRIEF' => ['Structured breakdown by school division and grade level', 'تفصيل منظم حسب المرحلة الدراسية والصف'],
            'ANNUAL_TUITION_JOD' => ['Annual Tuition (JOD)', 'الرسوم السنوية (دينار)'],
            'APPEAR_IN_DONOR_REPORT' => ['Would you like your name to appear in our annual donor report and other donor-related publications?', 'هل ترغب بظهور اسمك في تقرير المتبرعين السنوي والمنشورات ذات الصلة؟'],
            'APPLY_NOW' => ['Apply Now', 'قدّم الآن'],
            'ARE_YOU_AN_ABS_ALUMNI' => ['Are you an ABS Alumni?', 'هل أنت من خريجي ABS؟'],
            'ARE_YOU_AN_ABS_PARENT' => ['Are you an ABS Parent?', 'هل أنت ولي أمر في ABS؟'],
            'BOOK_A_CAMPUS_TOUR' => ['Book a Campus Tour', 'احجز جولة في الحرم المدرسي'],
            'CALENDAR' => ['Calendar', 'التقويم'],
            'CAN_ABS_SHARE_YOUR_EMAIL' => ['Can ABS share your email with fellow alumni?', 'هل يمكن لـ ABS مشاركة بريدك الإلكتروني مع زملائك الخريجين؟'],
            'CITY' => ['City', 'المدينة'],
            'CLASS_NOTE_BRIEF' => ["We'd love to hear from you and stay connected! Please share your updated contact information and any relevant details about your family, career and achievements.", 'يسعدنا أن نسمع منك وأن نبقى على تواصل! يرجى مشاركة معلومات الاتصال المحدثة وأي تفاصيل عن عائلتك ومسيرتك وإنجازاتك.'],
            'CLASS_OF_ABS' => ['Class of ABS (Graduation Year)', 'دفعة ABS (سنة التخرج)'],
            'CLICK_HERE_TO_READ_MORE' => ['Click here to read more', 'اضغط هنا لقراءة المزيد'],
            'COMPANY' => ['Company', 'الشركة'],
            'CONTACT_US' => ['Contact Us', 'تواصل معنا'],
            'CONTACT_US_BRIEF' => ['Contact our team for any questions about the school and seat availability.', 'تواصل مع فريقنا لأي استفسار عن المدرسة وتوفر المقاعد.'],
            'COUNTRY' => ['Country', 'الدولة'],
            'CURRENT_OCCUPATION' => ['Current Occupation/Title', 'المهنة / المسمى الوظيفي الحالي'],
            'CURRENT_PROFESSION' => ['Current Profession (Job Title and Employer)', 'المهنة الحالية (المسمى الوظيفي وجهة العمل)'],
            'DEGREES_AWARDED' => ['Degree(s) Awarded', 'الدرجات العلمية'],
            'DESIGNATION' => ['Designation', 'وجهة التبرع'],
            'DEVELOPED_BY' => ['Developed by', 'تطوير'],
            'DIVISION' => ['Division', 'المرحلة'],
            'EMAIL' => ['Email', 'البريد الإلكتروني'],
            'EMAIL_ADDRESS' => ['Email Address', 'البريد الإلكتروني'],
            'EMAIL_PLACEHOLDER' => ['info@example.com', 'info@example.com'],
            'ENQUIRE_NOW' => ['Enquire Now', 'استفسر الآن'],
            'EXPLORE_MORE' => ['Explore More', 'اكتشف المزيد'],
            'FIELD_OF_STUDY' => ['Field of Study (Major, Minor, etc.)', 'مجال الدراسة (التخصص الرئيسي، الفرعي...)'],
            'FILTER' => ['Filter', 'تصفية'],
            'FILTER_BY' => ['Filter By', 'تصفية حسب'],
            'FIRST_NAME' => ['First Name', 'الاسم الأول'],
            'FOOTER_SLOGAN' => ['45 years of Excellence', '45 عاماً من التميّز'],
            'GET_DIRECTIONS' => ['Get Directions', 'احصل على الاتجاهات'],
            'GIFT_AMOUNT' => ['Gift Amount', 'قيمة التبرع'],
            'GIFT_ON_BEHALF_OF_ORGANIZATION' => ['Make this gift on behalf of an organization', 'تقديم هذا التبرع باسم مؤسسة'],
            'GIFT_REMAIN_ANONYMOUS' => ['I would like this gift to remain anonymous', 'أرغب بأن يبقى هذا التبرع مجهول الاسم'],
            'GIVING_FORM_BRIEF' => ['Support your alma mater. Fields marked with * are required.', 'ادعم مدرستك. الحقول المميزة بـ * مطلوبة.'],
            'GIVING_FORM_TITLE' => ['Giving Page Form', 'نموذج العطاء'],
            'Google thinks, you are a bot, please refresh and try again!' => ['Google thinks, you are a bot, please refresh and try again!', 'يعتقد Google أنك روبوت، يرجى تحديث الصفحة والمحاولة مرة أخرى!'],
            'GRADE' => ['Grade', 'الصف'],
            'HOME' => ['Home', 'الرئيسية'],
            'HOME_ADDRESS' => ['Home Address', 'عنوان السكن'],
            'I_AM_A' => ['I am a', 'أنا'],
            'INITIAL_REGISTRATION' => ['Initial Registration', 'التسجيل الأولي'],
            'INTERESTED_ALUMNI_ACTIVITIES' => ['Are you interested in participating in any of the following alumni activities?', 'هل ترغب بالمشاركة في أي من أنشطة الخريجين التالية؟'],
            'IS_YOUR_SPOUSE_AN_ABS_ALUMNUS' => ['Is your spouse an ABS alumnus/alumna?', 'هل زوجك / زوجتك من خريجي ABS؟'],
            'JOD' => ['JOD', 'دينار'],
            'LAST_NAME' => ['Last Name', 'اسم العائلة'],
            'LATEST_STORIES' => ['Latest Stories', 'آخر الأخبار'],
            'LEAVE_A_COMMENT' => ['Leave a comment', 'اترك تعليقاً'],
            'LOAD_MORE' => ['Load More', 'تحميل المزيد'],
            'LOCATION_CITY_COUNTRY' => ['Location (City, Country)', 'الموقع (المدينة، الدولة)'],
            'MESSAGE' => ['Message', 'الرسالة'],
            'MIDDLE_NAME' => ['Middle Name', 'الاسم الأوسط'],
            'MOBILE_NUMBER' => ['Mobile Number', 'رقم الهاتف المحمول'],
            'MORE_NEWS' => ['More News', 'المزيد من الأخبار'],
            'MORE_STUDENT_ENGAGEMENT' => ['More Student Engagement', 'المزيد من الأنشطة الطلابية'],
            'NAME' => ['Name', 'الاسم'],
            'NAME_TITLE' => ['Title', 'اللقب'],
            'NEWS' => ['News', 'الأخبار'],
            'NEWS_BRIEF' => ['The latest news from ABS, including campus events and student achievements.', 'آخر أخبار ABS بما في ذلك فعاليات الحرم المدرسي وإنجازات الطلبة.'],
            'NO' => ['No', 'لا'],
            'NO_RESULTS_FOUND' => ['No results found', 'لا توجد نتائج'],
            'NOTABLE_ALUMNI_BRIEF' => ['Our graduates shape the world. Meet a few of the pioneers, athletes, and creators who started their journey at ABS.', 'خريجونا يصنعون العالم. تعرّف على بعض الروّاد والرياضيين والمبدعين الذين بدأوا رحلتهم في ABS.'],
            'NOTE_DETAILS' => ['Note Details', 'تفاصيل الملاحظة'],
            'OF' => ['of', 'من'],
            'OPEN_FLIPBOOK' => ['Open Flipbook', 'افتح الكتيب'],
            'ORGANIZATION_NAME' => ['Organization Name', 'اسم المؤسسة'],
            'OTHER' => ['Other', 'أخرى'],
            'PAGE' => ['Page', 'صفحة'],
            'PAYMENT_WITHDRAWAL_POLICIES' => ['Payment of Fees & Withdrawal Policies', 'سياسات دفع الرسوم والانسحاب'],
            'PERMISSION_TO_SHARE_CLASS_NOTE' => ['I agree to have my class note and photo shared in ABS communications.', 'أوافق على مشاركة ملاحظتي وصورتي في منشورات ABS.'],
            'PHONE' => ['Phone', 'الهاتف'],
            'PLEASE_SELECT' => ['Please Select', 'يرجى الاختيار'],
            'PRIVACY' => ['Privacy Policy', 'سياسة الخصوصية'],
            'PRIVACY_POLICY' => ['Privacy Policy', 'سياسة الخصوصية'],
            'READ_MORE' => ['Read More', 'اقرأ المزيد'],
            'READY_TO_BEGIN_YOUR_ABS_JOURNEY' => ['Ready to Begin Your ABS Journey?', 'هل أنت مستعد لبدء رحلتك في ABS؟'],
            'READY_TO_BEGIN_YOUR_ABS_JOURNEY_BRIEF' => ['Book a campus tour to experience our community firsthand, or start your application today. Our Admissions team is here to help at every step.', 'احجز جولة في الحرم المدرسي لتختبر مجتمعنا عن قرب، أو ابدأ طلبك اليوم. فريق القبول هنا لمساعدتك في كل خطوة.'],
            'RECEIVE_ABS_NEWS' => ['Would you like to receive the latest news, updates, and announcements from ABS?', 'هل ترغب باستلام آخر الأخبار والإعلانات من ABS؟'],
            'SCHOOLS' => ['Schools', 'المدارس'],
            'SEARCH' => ['Search', 'بحث'],
            'SEARCH_HINT' => ['Type a word to search the website.', 'اكتب كلمة للبحث في الموقع.'],
            'SEND_CONFIRMATION_EMAIL_TO' => ['Please send a confirmation email to the address below', 'يرجى إرسال رسالة تأكيد إلى البريد التالي'],
            'SHOWING' => ['Showing', 'عرض'],
            'SITE_MAP' => ['Site Map', 'خريطة الموقع'],
            'SOCIAL_MEDIA_LINKS' => ['Social Media Links if available', 'روابط مواقع التواصل الاجتماعي إن وجدت'],
            'STATE_ZIP' => ['State & zip', 'الولاية والرمز البريدي'],
            'STATUS' => ['Status', 'الحالة'],
            'STAY_CONNECTED_BRIEF' => ["We'd love to hear from you and stay connected! Please take a moment to share your updated contact information.", 'يسعدنا أن نسمع منك وأن نبقى على تواصل! يرجى مشاركة معلومات الاتصال المحدثة.'],
            'STAY_CONNECTED_FORM' => ['Stay Connected Form', 'نموذج البقاء على تواصل'],
            'STAY_CONNECTED_TITLE' => ['Stay Connected – ABS Alumni', 'ابقَ على تواصل – خريجو ABS'],
            'STAY_UPDATED' => ['Stay Updated', 'ابقَ على اطلاع'],
            'STAY_UPDATED_BRIEF' => ['Subscribe to receive the latest news from ABS, including campus events, student achievements, and admissions updates delivered directly to your inbox.', 'اشترك لتصلك آخر أخبار ABS بما في ذلك فعاليات الحرم المدرسي وإنجازات الطلبة وتحديثات القبول مباشرة إلى بريدك.'],
            'STUDENT_ENGAGEMENT' => ['Student Engagement', 'الأنشطة الطلابية'],
            'STUDENT_ENGAGEMENT_ALBUMS' => ['Student Engagement Albums', 'ألبومات الأنشطة الطلابية'],
            'STUDENT_ENGAGEMENT_TYPES' => ['Student Engagement types', 'أنواع الأنشطة الطلابية'],
            'SUBJECT' => ['Subject', 'الموضوع'],
            'SUBMIT' => ['Submit', 'إرسال'],
            'SUBMIT_A_CLASS_NOTE' => ['Submit a Class Note', 'أرسل ملاحظة الدفعة'],
            'SUBMIT_YOUR_PHOTO' => ['Submit Your Photo', 'أرفق صورتك'],
            'SUBMITTED_SUCCESSFULLY' => ['Thank you, your submission has been received successfully.', 'شكراً لك، تم استلام طلبك بنجاح.'],
            'SUBSCRIBE' => ['Subscribe', 'اشترك'],
            'SUGGESTIONS_FEEDBACK' => ['Do you have any suggestions or feedback for ABS or the alumni office?', 'هل لديك أي اقتراحات أو ملاحظات لـ ABS أو لمكتب الخريجين؟'],
            'SUPPORT_YOUR_ALMA_MATER' => ['Support your alma mater', 'ادعم مدرستك'],
            'TERMS_AND_CONDITIONS' => ['Terms and Conditions', 'الشروط والأحكام'],
            'TERMS_CONDITIONS' => ['Terms and Conditions', 'الشروط والأحكام'],
            'TRANSPORT_BUS_FEES' => ['Transport (Bus Fees)', 'المواصلات (رسوم الحافلات)'],
            'TRIBUTE' => ['Tribute', 'إهداء'],
            'TUITION_FEES' => ['Tuition Fees', 'الرسوم الدراسية'],
            'TYPE_HERE' => ['Type Here', 'اكتب هنا'],
            'UNIVERSITIES_ATTENDED' => ['Universities Attended', 'الجامعات التي درست فيها'],
            'UNIVERSITY_COLLEGE_NAME' => ['University/College Name', 'اسم الجامعة / الكلية'],
            'UNIVERSITY_DESTINATIONS' => ['University Destinations', 'وجهات الخريجين الجامعية'],
            'UNIVERSITY_DESTINATIONS_BRIEF' => ["Joining a global network of scholars at the world's most prestigious universities.", 'ينضم خريجونا إلى شبكة عالمية من الباحثين في أعرق جامعات العالم.'],
            'UPLOADING' => ['Uploading...', 'جارٍ الرفع...'],
            'VIEW_ALL_UNIVERSITIES' => ['View all universities', 'عرض جميع الجامعات'],
            'VOICES_OF_ABS' => ['Voices of ABS', 'أصوات من ABS'],
            'VOICES_OF_ABS_BRIEF' => ['Stories from our alumni and parents', 'قصص من خريجينا وأولياء الأمور'],
            'YEAR_OF_GRADUATION' => ['Year of Graduation from ABS', 'سنة التخرج من ABS'],
            'YES' => ['Yes', 'نعم'],
            'YOUR_ABS_JOURNEY_STARTS_HERE' => ['Your ABS Journey Starts Here', 'رحلتك في ABS تبدأ هنا'],
            'YOUR_ABS_JOURNEY_STARTS_HERE_BRIEF' => ['Your admissions journey, one step at a time — from your first question to your first day as a Stallion.', 'رحلة القبول خطوة بخطوة — من سؤالك الأول وحتى يومك الأول معنا.'],
            'YOUR_NOTE' => ['Your note', 'ملاحظتك'],
        ];

        foreach ($messages as $key => [$en, $ar]) {
            $existingId = DB::table('message')->where('category_id', $categoryId)->where('message', $key)->value('id');
            if ($existingId) {
                DB::table('message_lang')->where('parent_id', $existingId)->delete();
                $messageId = $existingId;
            } else {
                $messageId = DB::table('message')->insertGetId([
                    'category_id' => $categoryId,
                    'message' => $key,
                    'immutable' => 0,
                    'created_at' => $this->now,
                    'updated_at' => $this->now,
                    'created_by' => $this->userId,
                    'updated_by' => $this->userId,
                ]);
            }
            DB::table('message_lang')->insert([
                ['parent_id' => $messageId, 'language' => 'en', 'translation_value' => $en],
                ['parent_id' => $messageId, 'language' => 'ar', 'translation_value' => $ar],
            ]);
        }
    }
};
