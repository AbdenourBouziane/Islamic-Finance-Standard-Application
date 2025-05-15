class MockData {
  static final List<Map<String, dynamic>> standards = [
    {
      'id': 'FAS 4',
      'title_en': 'Musharaka Financing',
      'title_ar': 'التمويل بالمشاركة',
      'description_en': 'A form of partnership between the Islamic Financial Institution (IFI) and its clients whereby each party contributes to the capital of partnership in equal or varying degrees to establish a new project or share in an existing one, and whereby each of the parties becomes an owner of the capital on a permanent or declining basis and shall have his due share of profits. However, losses are shared in proportion to the contributed capital.',
      'description_ar': 'شكل من أشكال الشراكة بين المؤسسة المالية الإسلامية وعملائها حيث يساهم كل طرف في رأس مال الشراكة بدرجات متساوية أو متفاوتة لإنشاء مشروع جديد أو المشاركة في مشروع قائم، وحيث يصبح كل من الطرفين مالكًا لرأس المال على أساس دائم أو متناقص ويحصل على حصته المستحقة من الأرباح. ومع ذلك، يتم تقاسم الخسائر بنسبة رأس المال المساهم به.',
    },
    {
      'id': 'FAS 7',
      'title_en': 'Salam and Parallel Salam',
      'title_ar': 'السلم والسلم الموازي',
      'description_en': 'Salam is defined as the purchase of a commodity for deferred delivery in exchange for immediate payment according to specified conditions, or sale of a commodity for deferred delivery in exchange for immediate payment. Parallel Salam is a transaction whereby the seller in a Salam contract enters into another Salam contract with a third party to acquire goods of similar specifications.',
      'description_ar': 'السلم هو شراء سلعة مؤجلة التسليم مقابل دفع فوري وفقًا لشروط محددة، أو بيع سلعة مؤجلة التسليم مقابل دفع فوري. السلم الموازي هو معاملة يدخل فيها البائع في عقد سلم في عقد سلم آخر مع طرف ثالث للحصول على سلع بمواصفات مماثلة.',
    },
    {
      'id': 'FAS 10',
      'title_en': 'Istisna\'a and Parallel Istisna\'a',
      'title_ar': 'الاستصناع والاستصناع الموازي',
      'description_en': 'Istisna\'a is a sale contract whereby the seller undertakes to manufacture the goods for the buyer according to the specifications prescribed in the contract, in exchange for an agreed price. Parallel Istisna\'a is when the seller enters into a second Istisna\'a contract to fulfill contractual obligations in the first contract.',
      'description_ar': 'الاستصناع هو عقد بيع يتعهد فيه البائع بتصنيع السلع للمشتري وفقًا للمواصفات المحددة في العقد، مقابل سعر متفق عليه. الاستصناع الموازي هو عندما يدخل البائع في عقد استصناع ثانٍ للوفاء بالتزامات تعاقدية في العقد الأول.',
    },
    {
      'id': 'FAS 28',
      'title_en': 'Murabaha and Other Deferred Payment Sales',
      'title_ar': 'المرابحة وبيوع الدفع المؤجل الأخرى',
      'description_en': 'Murabaha is a sale of goods with an agreed upon profit mark-up on the cost. This could be on a spot basis or deferred payment basis. The standard covers accounting for Murabaha transactions including Murabaha to the purchase orderer, where the purchaser makes an order and confirms with a promise to purchase the specified subject matter on agreed Murabaha terms.',
      'description_ar': 'المرابحة هي بيع السلع مع هامش ربح متفق عليه على التكلفة. يمكن أن يكون ذلك على أساس فوري أو على أساس الدفع المؤجل. يغطي المعيار المحاسبة لمعاملات المرابحة بما في ذلك المرابحة للآمر بالشراء، حيث يقدم المشتري طلبًا ويؤكده بوعد بشراء الموضوع المحدد وفقًا لشروط المرابحة المتفق عليها.',
    },
    {
      'id': 'FAS 32',
      'title_en': 'Ijarah and Ijarah Muntahia Bittamleek',
      'title_ar': 'الإجارة والإجارة المنتهية بالتمليك',
      'description_en': 'Ijarah is the leasing of property pursuant to a contract under which a specified permissible benefit in the form of a usufruct is obtained for a specified period in return for a specified consideration. Ijarah Muntahia Bittamleek is a hybrid Ijarah arrangement which includes a promise resulting in transfer of ownership of the underlying asset to the lessee, either after the end of the Ijarah period or by stages during the term of the contract.',
      'description_ar': 'الإجارة هي تأجير ممتلكات بموجب عقد يتم بموجبه الحصول على منفعة محددة مسموح بها في شكل حق انتفاع لفترة محددة مقابل مقابل محدد. الإجارة المنتهية بالتمليك هي ترتيب إجارة هجين يتضمن وعدًا ينتج عنه نقل ملكية الأصل الأساسي إلى المستأجر، إما بعد نهاية فترة الإجارة أو على مراحل خلال مدة العقد.',
    },
  ];

  static final List<Map<String, dynamic>> examples = [
    {
      'standard_id': 'FAS 4',
      'title_en': 'Musharaka Financing for a Manufacturing Company',
      'title_ar': 'تمويل مشاركة لشركة تصنيع',
      'scenario_en': 'Noon IFI entered into a constant Musharaka with a customer by investing USD 1,000,000 in a bottled water manufacturing company whereas the customer invested USD 500,000. The partners agreed to share the profit in the ratio of 50% for the IFI and 50% for the customer. The venture earned profits of USD 10,000 in the first year and incurred losses of USD 20,000 in the second year. The Musharakah was terminated after the second year following the loss.\n\nHow should the IFI account for:\n1. The initial Musharaka financing\n2. The profit in the first year\n3. The loss in the second year\n4. The final settlement upon termination',
      'scenario_ar': 'دخل بنك نون في مشاركة ثابتة مع عميل من خلال استثمار 1,000,000 دولار أمريكي في شركة لتصنيع المياه المعبأة بينما استثمر العميل 500,000 دولار أمريكي. اتفق الشركاء على تقاسم الربح بنسبة 50٪ للمؤسسة المالية الإسلامية و 50٪ للعميل. حقق المشروع أرباحًا قدرها 10,000 دولار أمريكي في السنة الأولى وتكبد خسائر قدرها 20,000 دولار أمريكي في السنة الثانية. تم إنهاء المشاركة بعد السنة الثانية بعد الخسارة.\n\nكيف ينبغي للمؤسسة المالية الإسلامية أن تحاسب عن:\n1. تمويل المشاركة الأولي\n2. الربح في السنة الأولى\n3. الخسارة في السنة الثانية\n4. التسوية النهائية عند الإنهاء',
    },
    {
      'standard_id': 'FAS 7',
      'title_en': 'Salam Contract for Agricultural Products',
      'title_ar': 'عقد سلم للمنتجات الزراعية',
      'scenario_en': 'Hilal Islamic Bank entered into a Salam Contract with Golden Barley Company to purchase 50,000 Metric Tons of Barley at an agreed price of USD 100,000 to be delivered on May 15, 2024. Subsequently, the bank signed a Parallel Salam contract with Silver Barley & Co. to supply 50,000 Metric Tons of Barley (Salam Goods) at a price of USD 105,000. Golden Barley delivered the Salam Goods to Hilal Islamic Bank as per the agreed date. Under Parallel Salam, the goods were sold to Silver Barley & Co. on May 20, 2024.\n\nHow should the bank account for:\n1. The initial Salam transaction with Golden Barley Company\n2. The Parallel Salam transaction with Silver Barley & Co.\n3. The receipt of Salam goods under the first Salam\n4. The sale of goods under Parallel Salam',
      'scenario_ar': 'دخل بنك الهلال الإسلامي في عقد سلم مع شركة جولدن بارلي لشراء 50,000 طن متري من الشعير بسعر متفق عليه قدره 100,000 دولار أمريكي على أن يتم التسليم في 15 مايو 2024. وبعد ذلك، وقع البنك عقد سلم موازي مع شركة سيلفر بارلي لتوريد 50,000 طن متري من الشعير (بضائع السلم) بسعر 105,000 دولار أمريكي. قامت شركة جولدن بارلي بتسليم بضائع السلم إلى بنك الهلال الإسلامي حسب التاريخ المتفق عليه. وبموجب السلم الموازي، تم بيع البضائع إلى شركة سيلفر بارلي في 20 مايو 2024.\n\nكيف ينبغي للبنك أن يحاسب عن:\n1. معاملة السلم الأولية مع شركة جولدن بارلي\n2. معاملة السلم الموازي مع شركة سيلفر بارلي\n3. استلام بضائع السلم بموجب السلم الأول\n4. بيع البضائع بموجب السلم الموازي',
    },
    {
      'standard_id': 'FAS 10',
      'title_en': 'Istisna\'a Contract for Airport Terminal Construction',
      'title_ar': 'عقد استصناع لبناء محطة مطار',
      'scenario_en': 'Ehsan Islamic Bank entered into a two-year Istisna contract to construct an airport terminal commencing January 2023. Material and wages cost of USD 800,000 were estimated at the time of concluding the contract. Sales price of USD 1 million was agreed between the IFI and final purchaser. Construction was completed at the end of year 2024. Handover to final purchaser and 100% billings were also made at the end of year 2024.\n\nThe following payment schedule was agreed with the client:\n- 2023: 0%\n- 2024: 0%\n- 2025: 70%\n- 2026: 30%\n\nThe IFI recognizes revenue based on the percentage of completion method. How should the IFI account for this Istisna\'a contract from 2023 to 2026?',
      'scenario_ar': 'دخل بنك إحسان الإسلامي في عقد استصناع لمدة عامين لبناء محطة مطار ابتداءً من يناير 2023. تم تقدير تكلفة المواد والأجور بمبلغ 800,000 دولار أمريكي وقت إبرام العقد. تم الاتفاق على سعر بيع قدره مليون دولار أمريكي بين المؤسسة المالية الإسلامية والمشتري النهائي. تم الانتهاء من البناء في نهاية عام 2024. كما تم التسليم للمشتري النهائي وإصدار فواتير بنسبة 100٪ في نهاية عام 2024.\n\nتم الاتفاق على جدول الدفع التالي مع العميل:\n- 2023: 0٪\n- 2024: 0٪\n- 2025: 70٪\n- 2026: 30٪\n\nتعترف المؤسسة المالية الإسلامية بالإيرادات على أساس طريقة نسبة الإنجاز. كيف ينبغي للمؤسسة المالية الإسلامية أن تحاسب عن عقد الاستصناع هذا من 2023 إلى 2026؟',
    },
    {
      'standard_id': 'FAS 28',
      'title_en': 'Murabaha Financing for Oil Seed Flanker Machine',
      'title_ar': 'تمويل مرابحة لآلة فلانكر لبذور الزيت',
      'scenario_en': 'Ghurair Corporation is the largest producer of Palm Oil in Saudi Arabia. It approached an Islamic Financial Institution (IFI) to finance an Oil Seed flanker machine on the basis of Murabaha on February 1, 2024, with a deferred repayment arrangement. The machine was purchased for SR 150,000 by the IFI on March 1, 2024. The IFI also incurred SR 15,000 for transportation, takaful, and other expenses to bring the asset to the present condition and location. The machine was sold onwards on the same date on a credit period of 5 months. The selling price was agreed at SR 175,000, which Ghurair Corporation agreed to repay on July 31, 2024.\n\nHow should the IFI account for:\n1. Purchase of the Oil Seed Flanker Machine\n2. Sale under Deferred Payment Murabaha Contract\n3. Recording of Deferred Murabaha Profit\n4. Murabaha Profit Accruals at month-end\n5. Receipt of Cash Proceeds',
      'scenario_ar': 'شركة الغرير هي أكبر منتج لزيت النخيل في المملكة العربية السعودية. تقدمت إلى مؤسسة مالية إسلامية لتمويل آلة فلانكر لبذور الزيت على أساس المرابحة في 1 فبراير 2024، مع ترتيب سداد مؤجل. تم شراء الآلة بمبلغ 150,000 ريال سعودي من قبل المؤسسة المالية الإسلامية في 1 مارس 2024. كما تكبدت المؤسسة المالية الإسلامية 15,000 ريال سعودي للنقل والتكافل والمصاريف الأخرى لإحضار الأصل إلى الحالة والموقع الحاليين. تم بيع الآلة في نفس التاريخ على فترة ائتمان مدتها 5 أشهر. تم الاتفاق على سعر البيع بمبلغ 175,000 ريال سعودي، والذي وافقت شركة الغرير على سداده في 31 يوليو 2024.\n\nكيف ينبغي للمؤسسة المالية الإسلامية أن تحاسب عن:\n1. شراء آلة فلانكر لبذور الزيت\n2. البيع بموجب عقد مرابحة بالدفع المؤجل\n3. تسجيل ربح المرابحة المؤجل\n4. استحقاقات ربح المرابحة في نهاية الشهر\n5. استلام العائدات النقدية',
    },
    {
      'standard_id': 'FAS 32',
      'title_en': 'Ijarah Financing for Aircraft Leasing',
      'title_ar': 'تمويل إجارة لتأجير طائرة',
      'scenario_en': 'Tabarak Islamic Financing Corporation (TIFC) leases a small aircraft to Bey Flying Corp. (BFC) on June 23, 2023. TIFC sources the aircraft from an aircraft manufacturer for USD 300,000. The term of the Ijarah is ten years, and BFC is liable to make rental payments of USD 33,000 every year. To transport the aircraft to the premises of BFC, it pays direct costs of USD 1,000. After ten years, BFC is expected to incur dismantling costs of USD 4,000.\n\nHow should TIFC and BFC account for:\n1. The initial recognition of the right-of-use asset and Ijarah liability\n2. The calculation of the right-of-use asset cost\n3. The calculation of the gross Ijarah liability\n4. The calculation of deferred Ijarah cost',
      'scenario_ar': 'تؤجر شركة تبارك للتمويل الإسلامي (TIFC) طائرة صغيرة إلى شركة بي للطيران (BFC) في 23 يونيو 2023. تحصل TIFC على الطائرة من مصنع طائرات بمبلغ 300,000 دولار أمريكي. مدة الإجارة عشر سنوات، وتلت��م BFC بدفع إيجار قدره 33,000 دولار أمريكي كل عام. لنقل الطائرة إلى مقر BFC، تدفع تكاليف مباشرة قدرها 1,000 دولار أمريكي. بعد عشر سنوات، من المتوقع أن تتكبد BFC تكاليف تفكيك قدرها 4,000 دولار أمريكي.\n\nكيف ينبغي لـ TIFC و BFC أن يحاسبا عن:\n1. الاعتراف الأولي بأصل حق الاستخدام والتزام الإجارة\n2. حساب تكلفة أصل حق الاستخدام\n3. حساب إجمالي التزام الإجارة\n4. حساب تكلفة الإجارة المؤجلة',
    },
  ];

  static final List<Map<String, dynamic>> glossaryTerms = [
    {
      'term': 'Musharaka',
      'definition_en': 'A form of partnership between the Islamic Financial Institution (IFI) and its clients whereby each party contributes to the capital of partnership in equal or varying degrees to establish a new project or share in an existing one, and whereby each of the parties becomes an owner of the capital on a permanent or declining basis and shall have his due share of profits. However, losses are shared in proportion to the contributed capital.',
      'definition_ar': 'شكل من أشكال الشراكة بين المؤسسة المالية الإسلامية وعملائها حيث يساهم كل طرف في رأس مال الشراكة بدرجات متساوية أو متفاوتة لإنشاء مشروع جديد أو المشاركة في مشروع قائم، وحيث يصبح كل من الطرفين مالكًا لرأس المال على أساس دائم أو متناقص ويحصل على حصته المستحقة من الأرباح. ومع ذلك، يتم تقاسم الخسائر بنسبة رأس المال المساهم به.',
    },
    {
      'term': 'Murabaha',
      'definition_en': 'A sale of goods with an agreed upon profit mark-up on the cost. This could be on a spot basis or deferred payment basis. The standard covers accounting for Murabaha transactions including Murabaha to the purchase orderer, where the purchaser makes an order and confirms with a promise to purchase the specified subject matter on agreed Murabaha terms.',
      'definition_ar': 'بيع السلع مع هامش ربح متفق عليه على التكلفة. يمكن أن يكون ذلك على أساس فوري أو على أساس الدفع المؤجل. يغطي المعيار المحاسبة لمعاملات المرابحة بما في ذلك المرابحة للآمر بالشراء، حيث يقدم المشتري طلبًا ويؤكده بوعد بشراء الموضوع المحدد وفقًا لشروط المرابحة المتفق عليها.',
    },
    {
      'term': 'Ijarah',
      'definition_en': 'The leasing of property pursuant to a contract under which a specified permissible benefit in the form of a usufruct is obtained for a specified period in return for a specified consideration. In an operating Ijarah, the ownership of the leased asset remains with the lessor.',
      'definition_ar': 'تأجير ممتلكات بموجب عقد يتم بموجبه الحصول على منفعة محددة مسموح بها في شكل حق انتفاع لفترة محددة مقابل مقابل محدد. في الإجارة التشغيلية، تبقى ملكية الأصل المؤجر مع المؤجر.',
    },
    {
      'term': 'Ijarah Muntahia Bittamleek',
      'definition_en': 'A hybrid Ijarah arrangement which includes a promise resulting in transfer of ownership of the underlying asset to the lessee, either after the end of the Ijarah period or by stages during the term of the contract. Such transfer of ownership is executed through a sale or a gift, or a series of sales transactions.',
      'definition_ar': 'ترتيب إجارة هجين يتضمن وعدًا ينتج عنه نقل ملكية الأصل الأساسي إلى المستأجر، إما بعد نهاية فترة الإجارة أو على مراحل خلال مدة العقد. يتم تنفيذ نقل الملكية هذا من خلال البيع أو الهبة، أو سلسلة من معاملات البيع.',
    },
    {
      'term': 'Salam',
      'definition_en': 'Purchase of a commodity for deferred delivery in exchange for immediate payment according to specified conditions, or sale of a commodity for deferred delivery in exchange for immediate payment. The buyer is called Al-Muslam, the seller is Al-Muslam Ileihi, and the commodity is Al-Muslam Fihi.',
      'definition_ar': 'شراء سلعة مؤجلة التسليم مقابل دفع فوري وفقًا لشروط محددة، أو بيع سلعة مؤجلة التسليم مقابل دفع فوري. يسمى المشتري المسلم، والبائع المسلم إليه، والسلعة المسلم فيه.',
    },
    {
      'term': 'Istisna\'a',
      'definition_en': 'A sale contract whereby the seller undertakes to manufacture the goods for the buyer according to the specifications prescribed in the contract, in exchange for an agreed price. The buyer is called Al-Mustasni\', the seller is Al-Sani\', and the subject matter of the contract is Al-Masnoo\'.',
      'definition_ar': 'عقد بيع يتعهد فيه البائع بتصنيع السلع للمشتري وفقًا للمواصفات المحددة في العقد، مقابل سعر متفق عليه. يسمى المشتري المستصنع، والبائع الصانع، وموضوع العقد المصنوع.',
    },
  ];

  static String getCustomAnswer(String language) {
    if (language == 'English') {
      return 'This is a detailed answer to your question about Islamic finance. It references relevant AAOIFI standards and explains the principles in simple terms.';
    } else {
      return 'هذه إجابة مفصلة على سؤالك حول التمويل الإسلامي. تشير إلى معايير هيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية ذات الصلة وتشرح المبادئ بمصطلحات بسيطة.\n\nتعتبر معايير هيئة المحاسبة والمراجعة للمؤسسات المالية الإسلامية (AAOIFI) مرجعاً أساسياً للمؤسسات المالية الإسلامية حول العالم. تغطي هذه المعايير جوانب مختلفة من التمويل الإسلامي بما في ذلك المرابحة، الإجارة، المشاركة، السلم، والاستصناع.\n\nيمكنك الاطلاع على المزيد من التفاصيل في موقع الهيئة الرسمي أو من خلال الكتب والمراجع المتخصصة في هذا المجال.';
    }
  }

  static String getFeedback(String language) {
    if (language == 'English') {
      return 'Your solution is mostly correct. You correctly identified the key accounting entries, but you need to improve on the timing of recognition. Overall rating: 7/10.';
    } else {
      return 'حلك صحيح في معظمه. لقد حددت بشكل صحيح قيود المحاسبة الرئيسية، ولكن تحتاج إلى تحسين توقيت الاعتراف. التقييم العام: 7/10.\n\nنقاط القوة في إجابتك:\n- فهم جيد للمبادئ الأساسية\n- تطبيق صحيح للمعايير المحاسبية\n\nمجالات التحسين:\n- دقة توقيت الاعتراف بالمعاملات\n- تفاصيل القيود المحاسبية';
    }
  }

  static String getExplanation(String standardId, String language) {
    if (language == 'English') {
      return 'This is a detailed explanation of $standardId in English. It covers the accounting treatment, journal entries, and compliance with Islamic finance principles.';
    } else {
      String arabicExplanation = '';
      
      switch (standardId) {
        case 'FAS 4':
          arabicExplanation = 'شرح مفصل لمعيار المشاركة (FAS 4):\n\nيتناول هذا المعيار المعالجة المحاسبية لعقود المشاركة في المؤسسات المالية الإسلامية. المشاركة هي شراكة بين طرفين أو أكثر حيث يساهم كل طرف برأس مال ويشاركون في الأرباح والخسائر.\n\nالمعالجة المحاسبية الرئيسية:\n1. يتم تسجيل استثمار المشاركة بالتكلفة عند بدء العقد\n2. يتم الاعتراف بالأرباح وفقاً لنسبة توزيع الأرباح المتفق عليها\n3. يتم تحمل الخسائر بنسبة مساهمة رأس المال';
          break;
        case 'FAS 7':
          arabicExplanation = 'شرح مفصل لمعيار السلم والسلم الموازي (FAS 7):\n\nيتناول هذا المعيار المعالجة المحاسبية لعقود السلم في المؤسسات المالية الإسلامية. السلم هو عقد بيع يتم فيه دفع الثمن مقدماً مع تأجيل تسليم السلعة لوقت لاحق.\n\nالمعالجة المحاسبية الرئيسية:\n1. يتم تسجيل أصل السلم بقيمة رأس مال السلم المدفوع\n2. في حالة السلم الموازي، يتم تسجيل التزام بقيمة العقد\n3. عند استلام السلعة وبيعها، يتم الاعتراف بالفرق كربح أو خسارة';
          break;
        case 'FAS 10':
          arabicExplanation = 'شرح مفصل لمعيار الاستصناع والاستصناع الموازي (FAS 10):\n\nيتناول هذا المعيار المعالجة المحاسبية لعقود الاستصناع في المؤسسات المالية الإسلامية. الاستصناع هو عقد لتصنيع سلعة معينة وفقاً لمواصفات محددة.\n\nالمعالجة المحاسبية الرئيسية:\n1. يتم الاعتراف بالإيرادات والتكاليف باستخدام طريقة نسبة الإنجاز\n2. يتم تسجيل الأصول قيد الإنشاء بالتكلفة المتكبدة\n3. يتم الاعتراف بالربح تدريجياً مع تقدم العمل في المشروع';
          break;
        case 'FAS 28':
          arabicExplanation = 'شرح مفصل لمعيار المرابحة وبيوع الدفع المؤجل الأخرى (FAS 28):\n\nيتناول هذا المعيار المعالجة المحاسبية لعقود المرابحة في المؤسسات المالية الإسلامية. المرابحة هي بيع بزيادة معلومة على التكلفة.\n\nالمعالجة المحاسبية الرئيسية:\n1. يتم تسجيل الأصل بالتكلفة عند الشراء\n2. عند البيع، يتم تسجيل ذمم المرابحة المدينة بإجمالي قيمة البيع\n3. يتم تأجيل الاعتراف بربح المرابحة وتوزيعه على فترة العقد';
          break;
        case 'FAS 32':
          arabicExplanation = 'شرح مفصل لمعيار الإجارة والإجارة المنتهية بالتمليك (FAS 32):\n\nيتناول هذا المعيار المعالجة المحاسبية لعقود الإجارة في المؤسسات المالية الإسلامية. الإجارة هي عقد إيجار متوافق مع الشريعة الإسلامية.\n\nالمعالجة المحاسبية الرئيسية:\n1. يتم تسجيل أصل حق الاستخدام بالتكلفة\n2. يتم تسجيل التزام الإجارة بالقيمة الحالية للمدفوعات المستقبلية\n3. يتم توزيع دخل الإجارة على فترة العقد بطريقة منتظمة';
          break;
        default:
          arabicExplanation = 'هذا شرح مفصل لـ $standardId باللغة العربية. يغطي المعالجة المحاسبية، وقيود اليومية، والامتثال لمبادئ التمويل الإسلامي.';
      }
      
      return arabicExplanation;
    }
  }
}

