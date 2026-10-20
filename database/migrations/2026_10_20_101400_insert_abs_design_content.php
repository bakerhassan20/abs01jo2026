<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

/**
 * Initial website content taken from the ABS Figma design (Final Design page).
 * Arabic long texts are left empty so the site falls back to English until the client provides translations.
 */
return new class extends Migration
{
    private $now;
    private $userId = 1;

    public function up(): void
    {
        $this->now = time();

        $this->insertBms();
        $this->insertPagesContent();
        $schools = $this->insertSchools();
        $this->insertTuitionFees($schools);
        $this->insertTeam();
        $this->insertUniversities();
        $this->insertStudentEngagements();
        $this->insertNews();
    }

    public function down(): void
    {
        // data migration, restore from the SQL dump instead
    }


    private function insertTranslated(string $table, array $row, array $translations): int
    {
        $row += [
            'status' => 1,
            'published_at' => $this->now,
            'created_at' => $this->now,
            'updated_at' => $this->now,
            'created_by' => $this->userId,
            'updated_by' => $this->userId,
        ];

        $id = DB::table($table)->insertGetId($row);

        foreach ($translations as $language => $attributes) {
            DB::table($table . '_lang')->insert(['parent_id' => $id, 'language' => $language] + $attributes);
        }

        return $id;
    }

    private function bms(string $category, int $order, array $en, array $ar = [], array $row = []): int
    {
        static $counter = 0;
        $counter++;

        return $this->insertTranslated('bms', $row + [
            'slug' => $category . '-' . $counter,
            'category' => $category,
            'weight_order' => $order,
            'url' => $row['url'] ?? null,
        ], [
            'en' => $en,
            'ar' => $ar ?: ['title' => $en['title'] ?? null],
        ]);
    }

    private function list(array $items): string
    {
        return '<ul>' . implode('', array_map(fn ($item) => '<li>' . $item . '</li>', $items)) . '</ul>';
    }

    private function paragraphs(array $items): string
    {
        return implode('', array_map(fn ($item) => '<p>' . $item . '</p>', $items));
    }


    private function insertBms(): void
    {
        // Header ticker
        $this->bms('news-ticker', 1, ['title' => 'Amman Baccalaureate School achieves another national first by earning reaccreditation through the IB and NEASC Collaborative Learning Protocol'],
            ['title' => 'مدرسة البكالوريا - عمان تحقق إنجازاً وطنياً جديداً بحصولها على إعادة الاعتماد من خلال بروتوكول التعلم التعاوني بين IB و NEASC']);
        $this->bms('news-ticker', 2, ['title' => 'HRH Prince Hassan and HRH Princess Sarvath inaugurate the new Ahmad Mango sports field at the Amman Baccalaureate School'],
            ['title' => 'سمو الأمير الحسن وسمو الأميرة ثروت يفتتحان ملعب أحمد منكو الرياضي الجديد في مدرسة البكالوريا - عمان']);

        // Home hero
        $this->bms('home-hero', 1, ['title' => 'A Quality Education & Principled Upbringing Since 1981'], ['title' => 'تعليم نوعي وتنشئة قائمة على المبادئ منذ عام 1981']);

        // Why ABS
        $this->bms('why-abs', 1, [
            'title' => 'Why ABS',
            'brief' => 'The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students.',
            'content' => '<p>The Amman Baccalaureate School (ABS) was formed in 1981 upon a foundation of academic excellence, and a commitment to the holistic development of our students. Deeply rooted and firmly grounded in and proud of the rich and varied Jordanian culture and heritage. This is an ethos that remains today.</p>',
        ], ['title' => 'لماذا ABS'], ['url' => '/guiding-statement']);
        $features = [
            ['Arab Heritage & Culture', 'التراث والثقافة العربية', 'A deep-rooted connection to Jordanian and Arab heritage.'],
            ['Bilingual Excellence', 'التميّز ثنائي اللغة', 'An exceptional bilingual education and a strong command of Arabic and English.'],
            ['IB Continuum School', 'مدرسة IB متكاملة', 'Offering four IB Programmes (KG1-Gr 12) PYP, MYP, DP, CP'],
            ['Innovation', 'الابتكار', 'AI & Digital Technologies'],
        ];
        foreach ($features as $index => [$en, $ar, $brief]) {
            $this->bms('why-abs-features', $index + 1, ['title' => $en, 'brief' => $brief], ['title' => $ar]);
        }

        // Facts & figures: title = number, second_title = unit, brief = label
        $facts = [
            ['45+', null, 'Years of Excellence', 'عاماً من التميّز'],
            ['4', null, 'IB Programmes (PYP, MYP, DP, CP)', 'برامج IB'],
            ['86.000', 'm²', 'Campus Size', 'مساحة الحرم المدرسي'],
            ['1,165+', null, 'Students', 'طالب وطالبة'],
            ['190+', null, 'Faculty', 'معلم ومعلمة'],
            ['6:1', null, 'Student Ratio', 'نسبة الطلبة للمعلمين'],
            ['4-18', '(Years)', 'Age Range', 'الفئة العمرية'],
        ];
        foreach ($facts as $index => [$number, $unit, $en, $ar]) {
            $this->bms('facts-figures', $index + 1, ['title' => $number, 'second_title' => $unit, 'brief' => $en], ['title' => $number, 'second_title' => $unit, 'brief' => $ar]);
        }

        // Home schools cards: title = grades, second_title = school
        $cards = [
            ['KG1 - KG2', 'Primary School', 'الروضة الأولى - الروضة الثانية', 'المدرسة الابتدائية', '/schools/primary-school'],
            ['Grade 1 - Grade 6', 'Primary School', 'الصف الأول - الصف السادس', 'المدرسة الابتدائية', '/schools/primary-school'],
            ['Grade 7 - Grade 10', 'Secondary School – Middle', 'الصف السابع - الصف العاشر', 'المرحلة المتوسطة', '/schools/middle-school'],
            ['Grade 11 - Grade 12', 'Secondary School – IB College', 'الصف الحادي عشر - الصف الثاني عشر', 'كلية البكالوريا الدولية', '/schools/ib-college'],
        ];
        foreach ($cards as $index => [$en, $enSchool, $ar, $arSchool, $url]) {
            $this->bms('home-schools', $index + 1, ['title' => $en, 'second_title' => $enSchool], ['title' => $ar, 'second_title' => $arSchool], ['url' => $url]);
        }

        // Academic achievements: title = value, brief = label
        $achievements = [
            ['100%', 'IB Diploma pass rate', 'نسبة النجاح في دبلوم IB'],
            ['35', 'Achieved 40+ points', 'حصلوا على 40 نقطة فأكثر'],
            ['39', 'Average score', 'متوسط النقاط'],
            ['85%', 'Accepted to Top 100 Universities', 'قُبلوا في أفضل 100 جامعة'],
            ['42', 'Bilingual Diplomas Awarded', 'دبلوم ثنائي اللغة'],
            ['40+', 'Years of Academic Excellence', 'عاماً من التميّز الأكاديمي'],
        ];
        foreach ($achievements as $index => [$value, $en, $ar]) {
            $this->bms('academic-achievements', $index + 1, ['title' => $value, 'brief' => $en], ['title' => $value, 'brief' => $ar]);
        }

        // Accreditations (logos to be uploaded from the admin)
        $accreditations = ['ECIS', 'NEASC', 'IB Continuum School', 'International Baccalaureate', 'Ministry of Education - Jordan', 'Pearson BTEC'];
        foreach ($accreditations as $index => $title) {
            $this->bms('accreditations', $index + 1, ['title' => $title]);
        }

        // Testimonials: brief = quote, title = name, second_title = role
        $testimonials = [
            ['LANA GHANEM', 'Class of 2016 Alumna & Keynote Speaker', 'Life is a series of choices that we make to achieve our goals so make sure that your choices are immersed in passion.'],
            ['ABS PARENT', null, "My daughter's IB Diploma results opened doors we never imagined — she's now at a top UK university."],
            ['ABS PARENT', null, 'The bilingual program is exceptional — my son switches between Arabic and English with absolute confidence.'],
        ];
        foreach ($testimonials as $index => [$name, $role, $quote]) {
            $this->bms('testimonials', $index + 1, ['title' => $name, 'second_title' => $role, 'brief' => $quote]);
        }

        // Notable alumni
        $alumni = [
            ['Amjad Afanah', 'أمجد العفانة', 'Tech Entrepreneur, Software Architect, and Founder of cloud startup DCHQ.'],
            ['Hamdi Tabbaa', 'حمدي طباع', 'Founder and CEO of Abwaab, an innovative and leading regional EdTech platform.'],
            ['Princess Zeina Rashid', 'الأميرة زينة راشد', 'Olympic table tennis athlete and sports diplomat representing Jordan at international games.'],
        ];
        foreach ($alumni as $index => [$en, $ar, $brief]) {
            $this->bms('notable-alumni', $index + 1, ['title' => $en, 'brief' => $brief], ['title' => $ar]);
        }

        // Student engagement intro
        $this->bms('student-engagement-intro', 1, [
            'title' => 'What are Co-curricular Activities?',
            'brief' => 'These activities, such as sports, school bands, drama, educational trips and the arts, are not part of the academic curriculum, yet they are recognised as essential elements in the life of our ABS students. They provide opportunities to engage in diverse learning experiences that foster creativity, teamwork and personal growth. Far from being supplementary, co-curricular activities play a vital role in enhancing the learning process, making it both meaningful and enjoyable.',
        ], ['title' => 'ما هي الأنشطة المصاحبة للمنهاج؟']);

        // Tuition
        $this->bms('tuition-registration-fees', 1, ['title' => 'Administration Fee', 'brief' => 'Payable at application; non-refundable', 'second_title' => 'JD 100'], ['title' => 'رسوم إدارية', 'second_title' => '100 دينار']);
        $this->bms('tuition-registration-fees', 2, ['title' => 'Enrolment Fee', 'brief' => 'KG1 – Grade 12 upon confirmation; non-refundable', 'second_title' => 'JD 1,500'], ['title' => 'رسوم التسجيل', 'second_title' => '1,500 دينار']);
        $this->bms('tuition-transport', 1, ['title' => 'Round-trip (Morning & Afternoon):', 'brief' => 'JOD 935 / year  |  JOD 495 / semester'], ['title' => 'ذهاب وإياب (صباحاً ومساءً):']);
        $this->bms('tuition-transport', 2, ['title' => 'One-way trip (Morning or Afternoon):', 'brief' => 'JOD 580 / year  |  JOD 315 / semester'], ['title' => 'اتجاه واحد (صباحاً أو مساءً):']);
        $this->bms('tuition-policies', 1, ['title' => 'Seat Reservation:', 'brief' => "A seat reservation fee of JOD 1,000 is payable by January 31, by all existing students to secure your child's seat for the next academic year (deductible from tuition). If unpaid, the school will not guarantee your child's seat."], ['title' => 'حجز المقعد:']);
        $this->bms('tuition-policies', 2, ['title' => 'Tuition Deadlines & Installments:', 'brief' => 'Total tuition fees are due by April 30. Payment can be made in full in advance by April 30, (or within one week of acceptance), or by three (3) post-dated cheques in equal amounts dated: 30 April, 30 September, and 31 January. Failure to pay by the due date gives the school the right to accept new students from the waiting list.'], ['title' => 'مواعيد الدفع والأقساط:']);
        $this->bms('tuition-policies', 3, ['title' => 'Notification of Withdrawal:', 'brief' => "If the decision of withdrawing your child is taken after January 31, the seat reservation fee is non-refundable. Should a decision to withdraw your child occur during the academic year after fees have been paid, one month's fee (calculated as 1/9 of the tuition fee) will be due for each month or partial month of notice not given, starting from the due date of the first payment."], ['title' => 'إشعار الانسحاب:']);

        // Admissions procedure steps: second_title = step label
        $steps = [
            ['STEP ONE', 'Enquire', 'استفسر', 'Contact our Admissions team for any questions about the school and seat availability — email registrar@abs.edu.jo or call 0770 444 303.', '/contact-us'],
            ['STEP TWO', 'Book a Tour', 'احجز جولة', 'Discover Excellence: tour our campus and take your first steps into unlocking the ABS experience.', '/contact-us'],
            ['STEP THREE', 'Complete your Application Form', 'أكمل نموذج الطلب', 'Begin your ABS Adventure: Complete your application form now!', '/apply-now'],
            ['STEP FOUR', 'Family Interview', 'مقابلة العائلة', 'Our dedicated ABS team would like to get to know you and your family, share information about our school, community, and programs, and give you a chance to ask any questions.', null],
            ['STEP FIVE', 'Entrance Assessment', 'اختبار القبول', 'Once a seat is confirmed available, the applicant is invited to sit a grade- level appropriate entrance assessment.', null],
            ['STEP SIX', 'Your First Steps into Excellence', 'خطواتك الأولى نحو التميّز', 'Welcome to the Amman Baccalaureate School family. Your exceptional educational journey begins here.', null],
        ];
        $arSteps = ['الخطوة الأولى', 'الخطوة الثانية', 'الخطوة الثالثة', 'الخطوة الرابعة', 'الخطوة الخامسة', 'الخطوة السادسة'];
        foreach ($steps as $index => [$label, $en, $ar, $brief, $url]) {
            $this->bms('admissions-procedure', $index + 1, ['second_title' => $label, 'title' => $en, 'brief' => $brief], ['second_title' => $arSteps[$index], 'title' => $ar], ['url' => $url]);
        }

        // Apply now tabs
        $this->bms('apply-now', 1, [
            'title' => 'Primary School',
            'second_title' => 'Application Guidelines & Waiting Lists',
            'content' => '<h4>Application Timeline</h4><p>Applications should be submitted within 3 months of your child\'s birth. If a place is not available after the enrollment year, a 12 month waiting period will apply.</p>'
                . '<h4>Postponement Policy</h4><p>If you wish to postpone your child\'s application after a seat becomes available, the postponement is valid for 12 month period.</p>'
                . '<h3>KG2 – Grade 6 Procedures</h3><h4>Existing Waiting List:</h4><p>If your child is currently on our waiting list, you have a 12 month period, to secure a place. If a place is not available within this timeframe, your child will be removed from the list, and you need to renew the application.</p>'
                . '<h4>100 JOD Fee Policy</h4><p>If you pay the new registration fee of 100 JOD, no refund applies.</p>'
                . '<h4>New Registrations:</h4><p>Parents who register their child on the waiting list now will have a 12-month period to wait for an available seat. If a seat does not become available within this period, your child will be removed from the list, and you need to re-register.</p>',
        ], ['title' => 'المدرسة الابتدائية', 'second_title' => 'إرشادات التقديم وقوائم الانتظار']);
        $this->bms('apply-now', 2, [
            'title' => 'Secondary School (Grades 7 – 12)',
            'second_title' => 'Waiting List',
            'content' => '<p>Students on the waiting list have a 12-month period, to secure a place. If a place does not become available within this period, the student will be removed from the list and must reapply.</p>'
                . '<h4>Secondary School Application</h4><p>Applications for the 2025-2026 academic year will open on November 3, 2024, and close on March 3, 2025.</p>',
        ], ['title' => 'المدرسة الثانوية (الصفوف 7 – 12)', 'second_title' => 'قائمة الانتظار']);

        // Guiding statement values
        $values = [
            ['Arab Heritage', 'التراث العربي'], ['Lifelong Learners', 'متعلمون مدى الحياة'], ['Teamwork', 'العمل الجماعي'],
            ['Achievement', 'الإنجاز'], ['Responsibility', 'المسؤولية'], ['Bilingualism to Biliteracy', 'من ثنائية اللغة إلى ثنائية الإلمام بالقراءة والكتابة'],
            ['International Mindedness', 'العقلية الدولية'], ['Youth Agency', 'تمكين الشباب'], ['Excellence', 'التميّز'], ['Holistic Education', 'التعليم الشامل'],
        ];
        foreach ($values as $index => [$en, $ar]) {
            $this->bms('guiding-statement', $index + 1, ['title' => $en], ['title' => $ar]);
        }

        // Employment tabs
        $this->bms('employment', 1, [
            'title' => 'Employment',
            'content' => $this->paragraphs([
                'The Amman Baccalaureate School is an IB World School that provides a bilingual education in Arabic and English, which, whilst meeting the highest international standards, remains firmly rooted in the Arab heritage. The School is a Jordanian, non-profit institution that promotes international understanding, communication and awareness through embracing other cultures. The Amman Baccalaureate School works towards developing well rounded responsible world citizens.',
                'Working at ABS means working at an IB pioneer school in an exciting, enriching locality. It means working side by side with local Jordanians and international staff to maintain ABS’s high educational standards while preparing the next generation of youth for their positions as world changers and innovative creators.',
            ]) . '<h3>Salary and Benefits Package</h3><p>At Amman Baccalaureate School, we value the dedication and expertise of our educators and administrative staff. To support them, we offer a competitive salary and a comprehensive benefits package designed to attract, retain, and reward exceptional talent.</p>'
                . '<h4>International Teachers (hired from outside Jordan)</h4>' . $this->list([
                    'Competitive base salary aligned with qualifications, experience, and international standards',
                    'Gratuity payment in accordance with school policy, subject to successful completion of the academic year',
                    'Responsibility allowance for additional leadership roles or posts of responsibility',
                    'International allowance to support housing, utilities, relocation, and airfare (calculated based on destination and number of dependents)',
                    'Comprehensive health insurance for the employee and eligible dependents',
                    'Life insurance coverage for employees',
                    'Social Security contributions in accordance with Jordanian labor law',
                    'Visa and permits support, including work permits, residence permits for dependents, initial entry visas, and airport departure taxes',
                    'Tuition fee reduction for dependent children, in line with school policy',
                    'Transportation to and from School via bus, as per school policy',
                ]) . '<h4>Local Teachers (hired from inside Jordan)</h4>' . $this->list([
                    'Competitive base salary aligned with qualifications and experience',
                    'Responsibility allowance for posts of additional leadership or responsibility',
                    'Social Security and Provident Fund contributions in accordance with Jordanian labor law and school policy',
                    'Comprehensive health insurance for the employee and eligible dependents',
                    'Life insurance coverage for employees',
                    'Tuition fee reduction for dependent children, according to school policy',
                    'Transportation to and from School via bus, in line with the school policy',
                ]),
        ], ['title' => 'التوظيف']);
        $this->bms('employment', 2, [
            'title' => 'Opportunities',
            'content' => '<p>To review current opportunities at ABS, please click below.</p>',
        ], ['title' => 'الفرص الوظيفية']);
        $this->bms('employment', 3, [
            'title' => 'Living in Jordan',
            'content' => $this->paragraphs([
                'Jordan is a fascinating, friendly and safe place in which to live and work. Amman offers a rich mix of the old and the new with spectacular Roman ruins, buzzing coffee shops and souqs, modern shopping malls, art galleries and an international-standard museum. The ABS enjoys a privileged position in the leafy, affluent district of Western Amman.',
                'Culturally, Jordan offers many treasures and the Dead Sea, Baptismal Site, Petra and Jerash are all within easy reach.',
                'For those interested to venture further afield, Jordan is also well-placed as a hub from which to travel more widely within the region to Beirut, Cairo, the UAE and numerous other interesting destinations.',
            ]),
        ], ['title' => 'العيش في الأردن']);
    }


    private function pageContent(string $slug, string $content): void
    {
        $pageId = DB::table('page')->where('slug', $slug)->value('id');

        DB::table('page_lang')
            ->where('parent_id', $pageId)
            ->where('language', 'en')
            ->update(['content' => $content]);
    }

    private function insertPagesContent(): void
    {
        $this->pageContent('letter-from-the-principal', $this->paragraphs([
            'As Principal and CEO, it is my pleasure to welcome you to our vibrant and nurturing community where students are at the heart of everything we do. At the Amman Baccalaureate School (ABS), we take pride in offering an exceptional, student- centered educational experience that prepares young minds to thrive in an ever- changing world.',
            'Our mission is to develop well-rounded, lifelong learners who are confident, compassionate, and equipped with the skills and values needed to make a positive impact on the global stage. Guided by our vision of academic excellence and personal growth, we create an environment where students feel empowered to pursue their passions, explore their potential, and contribute to society.',
            'ABS is committed to innovation and excellence, combining rigorous academic programs with opportunities for holistic development. From the internationally recognised IB curriculum to our rich array of extracurricular activities, our school prioritizes the intellectual, emotional, and social growth of each individual.',
            '<strong>"We invite you to join us on this journey of discovery, creativity, and achievement as we continue to shape the leaders and innovators of tomorrow. At ABS, students are not just part of the school, they are the essence of it."</strong>',
            'Principal &amp; CEO',
        ]));

        $this->pageContent('guiding-statement',
            '<h2>Our Vision</h2><p>To provide a holistic, challenging, and enriching education to prepare rooted, connected respectful and impactful new generations who will make a positive difference in a changing and complex world.</p>'
            . '<h2>Our Mission</h2><h3>Al Tarbiyeh</h3>' . $this->paragraphs([
                'The Amman Baccalaureate School was formed in 1981, upon a foundation of academic excellence. Deeply rooted in our proud Jordanian heritage, this is an ethos that remains today.',
                "Students are encouraged to be intellectually curious and spiritually conscious, respecting difference without prejudice to one's own principles; to give the very best of themselves in all things; to be kind and compassionate to others; and to contribute to the community at school, at home and beyond.",
                'The school nurtures and encourages students to be resilient, adaptable, and passionate global citizens, ready to go out into the world as grounded, confident, upstanding men and women.',
                'These values are at the very core of our shared life, shaping a community of ethical learners with agency, who are an influence for good in a challenging and changing world.',
            ]) . '<h3>A quality education and principled upbringing</h3>');

        $this->pageContent('shared-understanding-of-high-quality-learning',
            '<p>High-Quality Learning at ABS combines inquiry-based, conceptual, experiential, and collaborative learning. It cultivates critical thinking, creativity and problem solving thereby enhancing personal growth and fostering agency. It engages learners in local and global issues so that they will be rooted, compassionate citizens who will have a positive impact on the world.</p>');

        $this->pageContent('additional-educational-needs',
            '<h2>Our philosophy</h2>' . $this->paragraphs([
                'At ABS, we believe that all children have the right to learn, regardless of their educational needs, within the regular educational system. We therefore work to create a school environment where every student feels valued, empowered, supported, and capable of thriving. As an IB Continuum school, ABS prioritises the learner through all stages of their academic and social-emotional development and works to ensure that its learners are supported in all aspects of their school journey, striving to create equitable opportunities so all learners are included.',
                'At ABS, an inclusive education is defined as one in which the teaching, learning, and wellbeing of every learner matters equally. We value and celebrate the uniqueness of each learner, fostering an environment where differences, interests, and talents are embraced within and beyond the classroom. This commitment ensures that learners have equitable access to suitable instruction and curricula, enabling them to progress and realise their potential both academically and as valued members of the school community.',
                'Our approach is proactive, recognising that early identification, intervention, and barrier removal are ethical imperatives that guide our efforts.',
            ]) . '<h2>Our purpose</h2>' . $this->list([
                'To support the overall well-being of all learners by addressing their educational, social- emotional, and physical needs.',
                'To foster strong collaboration with families and the school community to create an environment where all learners are valued and feel they fully belong.',
                'To address learners’ additional needs through personalised learning and to empower them to realise their fullest potential, ultimately enhancing student outcomes and promoting inclusive education.',
                'To empower all teachers to identify students’ needs and provide support within regular lessons.',
                'To provide the requisite provision through a team of professionals specialising in inclusion and student support.',
            ]));

        $this->pageContent('admissions-procedure',
            '<p>We are pleased you are considering our school for your family. We hope you will discover the warmth, friendliness and excitement that is at the heart of our bilingual and international learning community.</p>');

        $this->pageContent('apply-now',
            '<p>Applications are now submitted through our online portal. Payments can be made at our HRH Princess Sarvath El Hassan Welcome Center, Sunday – Thursday, 8:00 AM – 4:00 PM during the school year.</p>');

        $this->pageContent('tuition-fees',
            '<p>Transparent tuition structures, administrative fees, transport, and comprehensive policy guidelines.</p>'
            . '<p><small>*Ministry textbooks and stationery are supplied by the School. Costs of other textbooks, field trips, special courses, co-curricular activities, and Summer School are payable separately.</small></p>');

        $this->pageContent('development-department', $this->paragraphs([
            'Our mission is to inspire and support individuals and organizations in making meaningful financial contributions that empower ABS to achieve its vision and further its mission of serving the people of Jordan and beyond.',
            'At ABS, the Office of Development works in close partnership with the Board of Trustees, the Principal, faculty, and staff to secure vital funding for the school’s strategic priorities. Together, we aim to ensure a lasting impact and sustain ABS\'s commitment to excellence in education and community service.',
        ]));

        $this->pageContent('alumni', $this->paragraphs([
            'Welcome to the Alumni Relations Office at ABS! Our mission is to foster meaningful connections within the vibrant ABS community—bringing together alumni, faculty, and staff—while championing ABS’s founding vision of creating a better and more impactful society.',
            'The Office of Alumni Relations at ABS, proudly based in Amman, works hand-in-hand with ABS leadership, faculties, programs, and the OBS Alumni Association to cultivate a thriving and connected alumni community. Together, we collaborate on meaningful events, impactful programs, and philanthropic initiatives that advance the mission and legacy of our institution.',
            'Our commitment to staying connected with you drives us to organize initiatives that keep you actively engaged with your alma mater. Your accomplishments are a testament to ABS\'s excellence, and we take immense pride in celebrating your successes.',
            'We are eager to hear from you! Reach out to us anytime at development@abs.edu.jo. Let’s continue building the future of ABS—together.',
        ]));
    }


    private function tab(int $schoolId, string $slug, int $order, string $en, string $ar, ?string $content = null): int
    {
        return $this->insertTranslated('school_tab', ['school_id' => $schoolId, 'slug' => $slug, 'weight_order' => $order], [
            'en' => ['title' => $en, 'content' => $content],
            'ar' => ['title' => $ar],
        ]);
    }

    private function subject(int $tabId, string $slug, int $order, string $en, string $ar, ?string $brief = null, ?string $content = null): int
    {
        return $this->insertTranslated('school_subject', ['school_tab_id' => $tabId, 'slug' => $slug, 'weight_order' => $order], [
            'en' => ['title' => $en, 'brief' => $brief, 'content' => $content],
            'ar' => ['title' => $ar],
        ]);
    }

    private function insertSchools(): array
    {
        $primary = $this->insertTranslated('school', ['slug' => 'primary-school', 'weight_order' => 1], [
            'en' => [
                'title' => 'Primary School – KG1 - Grade 6',
                'grades_title' => 'KG1 - Grade 6',
                'brief' => 'A rigorous bilingual curriculum (Arabic and English) based on the IB Primary Years Programme.',
                'head_title' => 'Welcome from Head of Early Years',
                'head_name' => 'Amira Al Shawa',
                'head_content' => $this->paragraphs([
                    'The Early Years are a wonderful beginning to a child’s experience of school, filled with curiosity, discovery, and new possibilities. At the Amman Baccalaureate School, we provide a warm and stimulating environment where children develop a sense of belonging and are encouraged to explore the world around them.',
                    'As an integral part of the Primary School, our Kindergarten programme is guided by the IB Primary Years Programme (PYP). ABS was authorised to offer the PYP in 2015, becoming the first school in Jordan to offer a fully bilingual (Arabic and English) PYP programme. Through play, inquiry, and purposeful learning experiences, our children are encouraged to ask questions, investigate, share ideas, and develop a genuine love of learning.',
                    'With warm wishes,',
                ]),
            ],
            'ar' => ['title' => 'المدرسة الابتدائية – الروضة الأولى - الصف السادس', 'grades_title' => 'الروضة الأولى - الصف السادس', 'head_title' => 'كلمة رئيسة مرحلة الطفولة المبكرة', 'head_name' => 'أميرة الشوا'],
        ]);

        $middle = $this->insertTranslated('school', ['slug' => 'middle-school', 'weight_order' => 2], [
            'en' => [
                'title' => 'Secondary School – Middle School (Grades 7-10)',
                'grades_title' => 'Grades 7 - Grades 10',
                'brief' => 'The first school in the Middle East to be authorised to implement the IB Middle Years Programme.',
                'head_title' => 'Welcome From Head of Middle School',
                'head_name' => 'Miss Dima Qubain',
                'head_position' => 'Head of Middle School',
                'head_content' => $this->paragraphs([
                    'The Middle School is a nurturing and vibrant environment committed to nurturing curious, confident, compassionate, and independent young people.',
                    'The Middle School at Amman Baccalaureate school was the first school in the Middle East to be authorised to implement the IB Middle Years Programme in 2002.',
                    'The Middle School encompassing Grades 7–10, are a formative stage in every student’s journey. Our holistic programme combines academic challenge with opportunities for personal growth, wellbeing, leadership, creativity, and service.',
                    'Through a broad and balanced curriculum, students are encouraged to think critically, explore their interests, make meaningful connections, and take increasing ownership of their learning. They are supported to become reflective, resilient, and globally minded individuals who value diverse perspectives and contribute positively to their communities.',
                ]),
            ],
            'ar' => ['title' => 'المدرسة الثانوية – المرحلة المتوسطة (الصفوف 7-10)', 'grades_title' => 'الصف السابع - الصف العاشر', 'head_title' => 'كلمة رئيسة المرحلة المتوسطة', 'head_name' => 'الآنسة ديما قبعين'],
        ]);

        $ib = $this->insertTranslated('school', ['slug' => 'ib-college', 'weight_order' => 3], [
            'en' => [
                'title' => 'Secondary School – IB College (Grades 11-12)',
                'grades_title' => 'Grades 11 - Grades 12',
                'brief' => 'The full IB Diploma Programme and the IB Career-related Programme in the purpose-built Randa Kawar building.',
                'head_title' => 'Welcome from Head of IB College',
                'head_name' => 'Cathy Souob',
                'head_position' => 'Vice Principal for Professional Development and Student Progress/Head of IB College',
                'head_content' => $this->paragraphs([
                    'The IB College, located in the purpose-built Randa Kawar building, enjoys purposely designed learning and recreational spaces catering to the needs of our grades 11 and 12 students. This stimulating location and the experiences it offers provide students with the opportunity to develop a mature and age-appropriate independence within a structured and supportive environment. Within this environment, students are encouraged to develop their identity as world citizens and reach their academic potential.',
                    'On entering the IB College, students enroll on either the full IB Diploma Programme or, if deemed more appropriate, individual Diploma Courses. ABS was also the first school in Jordan to offer the Career-related programme, which offers a career-related pathway to university for those students whose future plans lend themselves to it.',
                ]),
            ],
            'ar' => ['title' => 'المدرسة الثانوية – كلية البكالوريا الدولية (الصفوف 11-12)', 'grades_title' => 'الصف الحادي عشر - الصف الثاني عشر', 'head_title' => 'كلمة رئيسة كلية البكالوريا الدولية', 'head_name' => 'كاثي صعوب'],
        ]);

        // Primary tabs
        $this->tab($primary, 'primary-overview', 1, 'Overview', 'نظرة عامة',
            '<h3>IB PYP Overview</h3><p>Agency is at the heart of the Primary Years Programme (PYP) framework, which is threaded throughout the three pillars of the PYP curriculum framework: the learner, learning and teaching, and the learning community. These interconnected components form a holistic, coherent programme that is trusted, timeless, and transformational.</p>'
            . $this->list([
                '<strong>The learner:</strong> describes the outcomes for individual learners and what they seek for themselves (What is learning?)',
                '<strong>Learning and teaching:</strong> outlines the distinctive features of learning and teaching (How best to support learners?)',
                '<strong>The learning community:</strong> highlights the importance of the social outcomes of learning and the role IB communities play in achieving these outcomes (Who facilitates learning and teaching?)',
            ]));
        $this->tab($primary, 'primary-the-learner', 2, 'The Learner', 'المتعلّم');
        $this->tab($primary, 'primary-learner-profile-attributes', 3, 'Learner Profile Attributes', 'سمات ملف المتعلّم');
        $primarySubjects = $this->tab($primary, 'primary-subject-briefs', 4, 'Learning and Teaching', 'التعلّم والتعليم',
            $this->paragraphs([
                'At the Amman Baccalaureate Primary School, we deliver a rigorous bilingual curriculum (Arabic and English) based on the International Baccalaureate Organisation Primary Years Programme (IB PYP). Teachers challenge learners to think critically and to develop an international mindset.',
                'The PYP curriculum framework is uniquely adaptable to local and national standards. Guided by six transdisciplinary themes of global significance, learners deepen their understanding by developing conceptual awareness, strengthening knowledge and skills across and beyond subject areas, and being supported by rigorous approaches to learning and teaching.',
            ]));
        $subjects = [
            ['primary-language', 'Language', 'اللغة', $this->list(['Oral language', 'Written language', 'Visual language'])],
            ['primary-mathematics', 'Mathematics', 'الرياضيات', null],
            ['primary-science', 'Science', 'العلوم', null],
            ['primary-social-studies', 'Social Studies', 'الدراسات الاجتماعية', null],
            ['primary-information-literacy', 'Information Literacy and Technology Integration', 'الثقافة المعلوماتية ودمج التكنولوجيا', null],
            ['primary-pspe', 'Personal, Social and Physical Education (PSPE)', 'التربية الشخصية والاجتماعية والبدنية', null],
            ['primary-transdisciplinary-themes', 'Transdisciplinary Themes', 'المحاور العابرة للتخصصات', '<p>Throughout the year, learners inquire into globally significant issues through Units of Inquiry, which are organised within the Programme of Inquiry. Each unit addresses a central idea connected to one of the six transdisciplinary themes. During the school year, Kindergarten learners explore five Units of Inquiry, while learners in Grades 1–6 explore six.</p>'],
        ];
        foreach ($subjects as $index => [$slug, $en, $ar, $brief]) {
            $this->subject($primarySubjects, $slug, $index + 1, $en, $ar, $brief);
        }

        // Middle school tabs
        $this->tab($middle, 'middle-overview', 1, 'Overview', 'نظرة عامة',
            '<h3>Middle School Overview</h3><p>The Middle School includes grades 7-10. They learn within the Middle Years Programme framework (MYP)</p>'
            . '<p>In the programme model for the MYP, the first ring around the student at the centre describes the features of the programme that help students develop disciplinary (and interdisciplinary) understanding.</p>'
            . '<p>IB philosophy in the MYP This philosophy, framed in What is an IB education? (2019), is expressed through all aspects of the MYP.</p>'
            . '<p>The programme has been developed with developmentally appropriate attention to:</p>'
            . $this->list(['Conceptual understanding', 'Learning and teaching in context', 'Approaches to learning (ATL)', 'Service as action (community service)', 'Language and identity', 'Learning diversity and inclusion.'])
            . '<p>All MYP students are encouraged to participate in a wide variety of cultural, sporting and service activities. All students are also able to take part in Community Service as a co-curricular activity. The compulsory Service as Action component of the MYP will be part of the academic programme.</p>');
        $middleSubjects = $this->tab($middle, 'middle-subject-briefs', 2, 'Subject Briefs', 'ملخص المواد');
        $this->tab($middle, 'middle-personal-project', 3, 'The Personal Project', 'المشروع الشخصي');
        $this->tab($middle, 'middle-service-as-action', 4, 'Service as Action', 'الخدمة كعمل');

        $mathBrief = '<h4>Course description and aims</h4><p>The framework for MYP mathematics outlines four branches of mathematical study.</p>'
            . $this->list(['Numerical and abstract reasoning', 'Thinking with models', 'Spatial reasoning', 'Reasoning with data'])
            . '<p>The study of mathematics is a fundamental part of a balanced education. It promotes a powerful universal language, analytical reasoning and problem-solving skills that contribute to the development of logical, abstract and critical thinking. The MYP mathematics and extended mathematics courses promote both inquiry and application, helping students to develop problem-solving techniques that transcend the discipline and are useful in the world outside school.</p>'
            . '<p>Mathematics in the MYP is tailored to the needs of students, seeking to intrigue and motivate them to want to learn its principles. Students should see authentic examples of how mathematics is useful and relevant to their lives and be encouraged to apply it to new situations.</p>';
        $mathContent = $mathBrief
            . '<p>The aims of MYP mathematics courses are to encourage and enable students to:</p>'
            . $this->list([
                'enjoy mathematics, develop curiosity and begin to appreciate its elegance and power',
                'develop an understanding of the principles and nature of mathematics',
                'communicate clearly and confidently in a variety of contexts',
                'develop logical, critical and creative thinking',
                'develop confidence, perseverance and independence in mathematical thinking and problem-solving',
                'develop powers of generalization and abstraction',
                'apply and transfer skills to a wide range of real-life situations, other areas of knowledge and future developments',
                'appreciate how developments in technology and mathematics have influenced each other',
                'develop the knowledge, skills and attitudes necessary to pursue further studies in mathematics',
                'develop the ability to reflect critically upon their own work and the work of others.',
            ])
            . '<h4>Curriculum model overview</h4>'
            . $this->list([
                'For MYP mathematics, schools can develop courses at two level of challenge: standard and extended.',
                'Standard mathematics aims to provide a sound knowledge of basic mathematical principles.',
                'Extended mathematics supplements the standard curriculum with additional topics and skills, providing greater breadth and depth of study.',
                'The MYP promotes sustained inquiry in mathematics by developing conceptual understanding within global contexts.',
                'Key concepts such as form, logic and relationships broadly frame the MYP curriculum.',
                'The MYP requires at least 50 hours of teaching time for each subject area in each year of the programme.',
            ]);
        $subjects = [
            ['middle-mathematics', 'Mathematics', 'الرياضيات', $mathBrief, $mathContent],
            ['middle-sciences', 'Sciences', 'العلوم', null, null],
            ['middle-individuals-and-societies', 'Individuals and Societies', 'الفرد والمجتمع', null, null],
            ['middle-language-and-literature', 'Language and Literature (Arabic and English)', 'اللغة والأدب (العربية والإنجليزية)', null, null],
            ['middle-language-acquisition', 'Language Acquisition (Arabic, Spanish and French)', 'اكتساب اللغة (العربية والإسبانية والفرنسية)', null, null],
            ['middle-arts', 'Arts', 'الفنون', null, null],
            ['middle-design', 'Design', 'التصميم', null, null],
            ['middle-interdisciplinary', 'Interdisciplinary', 'متعدد التخصصات', null, null],
        ];
        foreach ($subjects as $index => [$slug, $en, $ar, $brief, $content]) {
            $this->subject($middleSubjects, $slug, $index + 1, $en, $ar, $brief, $content);
        }

        // IB college tabs
        $ibOverview = $this->tab($ib, 'ib-overview', 1, 'Overview', 'نظرة عامة',
            '<h3>Overview of the International Baccalaureate at Amman Baccalaureate School</h3>'
            . $this->paragraphs([
                'The International Baccalaureate is the world’s foremost international qualification, opening doors to top universities and careers worldwide. With over 30 years of IB experience, Amman Baccalaureate School provides students with a world-class IB education, expert university guidance, and a strong support network. As a result, our graduates have gained admission to elite institutions in Jordan, the UK, the US, Canada, Australia, and Europe building on their IB qualifications to gain scholarships, internships, and leadership opportunities.',
                'At Amman Baccalaureate School (ABS), we are proud to offer two world-renowned International Baccalaureate (IB) pathways—both academically rigorous and internationally recognised—designed to enable students develop their abilities, pursue their ambitions and achieve their future aspirations.',
            ]));
        $this->subject($ibOverview, 'ib-diploma-programme', 1, 'The IB Diploma Programme: A Gateway to Top Universities', 'برنامج دبلوم IB: بوابة إلى أفضل الجامعات');
        $this->subject($ibOverview, 'ib-career-related-programme', 2, 'The IB Career-related Programme (CP): Pathway to Professional Success', 'برنامج IB المهني (CP): طريقك إلى النجاح المهني');
        $this->tab($ib, 'ib-diploma-programme-results', 2, 'Diploma Programme Results', 'نتائج برنامج الدبلوم');
        $this->tab($ib, 'ib-college-curriculum', 3, 'IB College Curriculum', 'منهاج كلية البكالوريا الدولية');

        return ['primary' => $primary, 'middle' => $middle, 'ib' => $ib];
    }


    private function insertTuitionFees(array $schools): void
    {
        $fees = [
            'primary' => [['KG1', 'الروضة الأولى', 7385], ['KG2', 'الروضة الثانية', 7385], ['Grade 1', 'الصف الأول', 7936], ['Grade 2', 'الصف الثاني', 7936], ['Grade 3', 'الصف الثالث', 7936], ['Grade 4', 'الصف الرابع', 9060], ['Grade 5', 'الصف الخامس', 9060], ['Grade 6', 'الصف السادس', 10223]],
            'middle' => [['Grade 7', 'الصف السابع', 10715], ['Grade 8', 'الصف الثامن', 11522], ['Grade 9', 'الصف التاسع', 12333], ['Grade 10', 'الصف العاشر', 13473]],
            'ib' => [['Grade 11', 'الصف الحادي عشر', 16425], ['Grade 12', 'الصف الثاني عشر', 17284]],
        ];

        $order = 1;
        foreach ($fees as $school => $grades) {
            foreach ($grades as [$en, $ar, $amount]) {
                $this->insertTranslated('tuition_fee', [
                    'school_id' => $schools[$school],
                    'slug' => 'tuition-2026-2027-' . \Illuminate\Support\Str::slug($en),
                    'academic_year' => '2026-2027',
                    'amount' => $amount,
                    'weight_order' => $order++,
                ], [
                    'en' => ['title' => $en],
                    'ar' => ['title' => $ar],
                ]);
            }
        }
    }


    private function insertTeam(): void
    {
        $board = DB::table('dropdown_list')->where('category', 'Team Category')->where('slug', 'board-of-trustees')->value('id');
        $leadership = DB::table('dropdown_list')->where('category', 'Team Category')->where('slug', 'senior-leadership-team')->value('id');

        $this->insertTranslated('team_member', ['category_id' => $board, 'slug' => 'hrh-princess-sumaya-bint-el-hassan', 'is_featured' => 1, 'weight_order' => 1], [
            'en' => [
                'title' => 'HRH Princess Sumaya bint El Hassan',
                'position' => 'Chair of the Board of Trustees',
                'brief' => 'HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change.',
                'content' => $this->paragraphs([
                    'HRH Princess Sumaya bint El Hassan is a leading advocate for science as a catalyst for change. She is a dedicated science enabler in the Arab World where so many challenges urgently require science-based solutions. The Princess has worked for almost two decades to help foster an environment for home- grown solutions to be found for pressing issues facing the region.',
                    "HRH was appointed Chair of the Board of the Amman Baccalaureate School in August 2021 on the retirement of Chair and Co-founder, HRH Princess Sarvath El Hassan. Princess Sumaya had joined the Board in 2005 and has been consistently active in the school's daily and strategic management.",
                    'HRH is President of the Royal Scientific Society (RSS), Chair of the Princess Sumaya University for Technology (PSUT), and Vice-Chair of the Jordan Museum. In August 2020, the Director General of UNESCO appointed HRH as UNESCO Goodwill Ambassador for Science for Peace.',
                ]),
            ],
            'ar' => ['title' => 'سمو الأميرة سمية بنت الحسن', 'position' => 'رئيسة مجلس الأمناء'],
        ]);

        $members = [
            ['mr-shahm-al-wir', 'Mr Shahm M. Al-Wir', 'السيد شهم الوير', 'Shahm is a Partner of Foursan Group, a leading Middle Eastern private equity firm. Prior to joining Foursan in 2007, Shahm was a Senior Associate with Debevoise & Plimpton in New York, a global law firm.'],
            ['mrs-zeena-majali', 'Mrs Zeena Majali', 'السيدة زينة المجالي', 'Zeena Majali co-founded Crystel in 2007. The first outsourcing contact center in Jordan, Crystel employs 2,000 Jordanians, providing superior global customer service. Following Crystel’s success, Zeena cofounded “Xina AI,” a company specializing in Arabic speech synthesis and natural language understanding.'],
            ['he-mrs-majd-shweikeh', 'HE Mrs Majd Shweikeh', 'معالي السيدة مجد شويكة', 'As a goal focused strategist with a talent for persuasive communication and a passion for inspiring others to accomplish visionary business goals, Excellency Shweikeh combines creativity with a data-driven approach to ensuring organizations are structured and equipped with the strategies; structures; technologies and high potential leaders.'],
            ['mrs-mary-tadros', 'Mrs Mary Tadros', 'السيدة ماري تادرس', 'Mary is a Senior Manager, Development, Recognition and eAssessment with the IB. She is a lead IB educator with extensive experience as a workshop leader, consultant, team leader, visiting team chair and programme and evaluation leader for school evaluation visits. She also chairs New England Association of schools and colleges (NEASC).'],
            ['mr-maher-kaddoura', 'Mr Maher Kaddoura', 'السيد ماهر قدورة', 'Maher Kaddoura is a management consultant, serial entrepreneur, angel investor, social change maker, public speaker and adventurer. Upon retirement as Accenture-Middle East managing partner, he established a number of professional services firms which became regional leaders in their relative sectors. Maher established Al-Jude NGO in 1999.'],
            ['mrs-tamara-al-qadi', 'Mrs Tamara Al Qadi', 'السيدة تمارا القاضي', 'Tamara Marei Al-Qadi is a wife and mother of four who was born and raised in Amman, Jordan and completed her Civil Engineering degree from The University of Jordan. She is a strong believer in giving back to the community, be it socially or otherwise. Tamara takes active roles in non-governmental organizations.'],
            ['mrs-nour-masri', 'Mrs. Nour Masri', 'السيدة نور المصري', null],
            ['mr-zeid-bdeir', 'Mr Zeid Bdeir', 'السيد زيد بدير', 'Zeid Bdeir is an ABS graduate, year 1996. He was the recipient of ECIS award, and was the first ABS student to receive the prestigious Gold Award of the then pioneering Crown Prince Award, which is today known as the El Hassan Youth Award, akin to the Duke of Edinburgh International Award. He went on to receive his bachelor\'s degree in Civil Engineering.'],
        ];
        foreach ($members as $index => [$slug, $en, $ar, $bio]) {
            $this->insertTranslated('team_member', ['category_id' => $board, 'slug' => $slug, 'weight_order' => $index + 2], [
                'en' => ['title' => $en, 'position' => 'Board Member', 'brief' => $bio ? \Illuminate\Support\Str::limit($bio, 250) : null, 'content' => $bio ? '<p>' . $bio . '</p>' : null],
                'ar' => ['title' => $ar, 'position' => 'عضو مجلس الأمناء'],
            ]);
        }

        $leaders = [
            ['mr-fiyaz-ahmed', 'Mr Fiyaz Ahmed', 'السيد فياض أحمد', null, null],
            ['ms-cathy-souob', 'Ms Cathy Souob', 'السيدة كاثي صعوب', 'Vice Principal for Professional Development and Student Progress/Head of IB College', 'نائبة المدير للتطوير المهني وتقدم الطلبة / رئيسة كلية البكالوريا الدولية'],
            ['ms-dima-qubain', 'Ms Dima Qubain', 'الآنسة ديما قبعين', 'Head of Middle School', 'رئيسة المرحلة المتوسطة'],
        ];
        foreach ($leaders as $index => [$slug, $en, $ar, $position, $arPosition]) {
            $this->insertTranslated('team_member', ['category_id' => $leadership, 'slug' => $slug, 'weight_order' => $index + 1], [
                'en' => ['title' => $en, 'position' => $position],
                'ar' => ['title' => $ar, 'position' => $arPosition],
            ]);
        }
    }


    private function insertUniversities(): void
    {
        $universities = [
            ['columbia-university', 'Columbia University', 'جامعة كولومبيا', 'https://www.columbia.edu'],
            ['ucl', 'University College London (UCL)', 'كلية لندن الجامعية', 'https://www.ucl.ac.uk'],
            ['harvard-university', 'Harvard University', 'جامعة هارفارد', 'https://www.harvard.edu'],
            ['yale-university', 'Yale University', 'جامعة ييل', 'https://www.yale.edu'],
            ['university-of-cambridge', 'University of Cambridge', 'جامعة كامبريدج', 'https://www.cam.ac.uk'],
            ['kings-college-london', "King's College London", 'كينغز كوليدج لندن', 'https://www.kcl.ac.uk'],
            ['stanford-university', 'Stanford University', 'جامعة ستانفورد', 'https://www.stanford.edu'],
        ];
        foreach ($universities as $index => [$slug, $en, $ar, $url]) {
            $this->insertTranslated('university', ['slug' => $slug, 'url' => $url, 'is_featured' => 1, 'weight_order' => $index + 1], [
                'en' => ['title' => $en],
                'ar' => ['title' => $ar],
            ]);
        }
    }


    private function insertStudentEngagements(): void
    {
        $engagements = [
            ['athletic-and-recreation', 'Athletic and Recreation', 'الرياضة والترفيه'],
            ['extra-co-curricular-activities-and-cas', 'Extra Co-Curricular Activities and CAS', 'الأنشطة اللامنهجية و CAS'],
            ['adventure-and-leadership', 'Adventure and Leadership', 'المغامرة والقيادة'],
            ['arts-and-culture', 'Arts and Culture', 'الفنون والثقافة'],
            ['academic-enrichment', 'Academic Enrichment', 'الإثراء الأكاديمي'],
        ];

        foreach ($engagements as $index => [$slug, $en, $ar]) {
            $english = ['title' => $en];
            if ($slug == 'athletic-and-recreation') {
                $english += [
                    'brief' => 'Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity.',
                    'content' => $this->paragraphs([
                        'Our Athletics Programme is a cornerstone of student life, sparking a passion for sports and physical activity. Athletics play a key role in shaping character, teaching teamwork, and building resilience. We provide an environment where students are encouraged to push their limits, embrace challenges, and grow as athletes and individuals.',
                        'Our programme offers a wide range of sports, allowing students to discover and pursue their passions. From team sports like football, basketball, and volleyball to individual pursuits such as track and field, tennis, and gymnastics, we cater to diverse interests and abilities. Every student has the opportunity to explore their athletic potential and find the sport that resonates with them.',
                        'Whether students aim to compete at the highest level, stay active, or enjoy the camaraderie of being part of a team, our athletics programme has something for everyone. We are dedicated to nurturing the talents and passions of our students, fostering a love for sports, and preparing them for success in both athletic and academic pursuits.',
                    ]),
                    'list_title' => 'Athletics and Recreation',
                    'list_content' => $this->list(['Basketball', 'Basketball Little League', 'Chess', 'Cycling Club by Bike Rush', 'Flag American Football', 'Football', 'Football Little League', 'Get Fit', 'Gymnastics', 'Kick Boxing - Jujutsu', 'Padel Tennis', 'Tennis', 'Track & Field', 'Volleyball', 'Zumba']),
                ];
            }

            $this->insertTranslated('student_engagement', ['slug' => $slug, 'weight_order' => $index + 1], [
                'en' => $english,
                'ar' => ['title' => $ar],
            ]);
        }
    }


    private function insertNews(): void
    {
        $category = DB::table('dropdown_list')->where('category', 'News Category')->where('slug', 'school-news')->value('id');

        $news = [
            ['abs-students-shine-at-annual-science-and-innovation-fair', 'ABS Students Shine at Annual Science and Innovation Fair', 'طلبة ABS يتألقون في معرض العلوم والابتكار السنوي'],
            ['class-of-2026-achieves-record-ib-diploma-results', 'Class of 2026 Achieves Record IB Diploma Results', 'دفعة 2026 تحقق نتائج قياسية في دبلوم IB'],
            ['primary-students-embark-on-outdoor-education-week', 'Primary Students Embark on Outdoor Education Week', 'طلبة المرحلة الابتدائية ينطلقون في أسبوع التعليم الخارجي'],
            ['abs-hosts-inter-school-model-united-nations-conference', 'ABS Hosts Inter-School Model United Nations Conference', 'ABS تستضيف مؤتمر نموذج الأمم المتحدة بين المدارس'],
        ];

        foreach ($news as $index => [$slug, $en, $ar]) {
            $this->insertTranslated('news', ['slug' => $slug, 'category_id' => $category, 'weight_order' => 10, 'published_at' => $this->now - $index * 86400], [
                'en' => ['title' => $en],
                'ar' => ['title' => $ar],
            ]);
        }
    }
};
