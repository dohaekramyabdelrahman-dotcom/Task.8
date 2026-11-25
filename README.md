# Search task
--1- Delete vs truncate 
الاتنين بستخدمهم لحدف البيانات من الجدول لكن كل واحده فيهم ليها طريقة عمل مختلف و الاتنين ممكن نعملهم Rollback لو اتنفذوا داخل Transaction ولسه معملناش Commit 
اولا Delete : 
بتحذف صفوف من الجدول وممكن استخدم معاها where و بيحذف Row by Row و بيسجل عمليات الحذف في Transaction Log و بيحافظ على قيمة Identity الحالية و ممكن يتعامل مع Foreign Key بشروط و ممكن تحذفي بيه بيانات معينة أو كل البيانات
ثانيا truncate :
بتحذف كل االصفوف ومينفعش استخدم where و بيحذف البيانات بطريقة أسرع و بيسجل معلومات أقل عن عملية الحذف و بيرجع Identity للـ Seed و مينفعش لو الجدول Referenced by Foreign Key و بيحذف كل البيانات فقط لكن الجدول نفسه بيفضل موجود بالـ Structure بتاعه.
--2- Transaction Log Backup
اولا Transaction Log
 هو ملف في SQL Server بيسجل التغييرات والعمليات اللي بتحصل على Database زى insert , delete , update  بيسجل معلومات في الـ Transaction Log
ثانيا Transaction Log Backup
هو Backup للـ Transaction Log بيساعدنا نسترجع الـ Database لنقطة زمنية معينة وبيساعد في إدارة مساحة الـ Log من آخر Log Backup
--3- what is database Job (o)
هو مهمة أو مجموعة مهام بنخلي SQL Server ينفذها بشكل تلقائي في وقت معين أو على فترات متكررة و بنستخدمه من خلال SQL Server Agent بكل بساطه بدل ما كل يوم اعمل Backup بنفسي اعمل Job ينفذ العملية تلقائيا 
ال job بتتكون من 1- steps:الاوامر او العمليات المطلوب تنفيذها 2- Schedules: تحديد موعد تنفيذ ال jop 
بقدر استخدمه فى اتمتتة المهام المتكررة و عمل نسخ احتياطية لقاعدة البيانات و حذف السجلات القديمة و تحديث الاحصائيات و اعادة بناء ال index 
ال job history سجل بيوضح نتيجة تنفيذ ال jop سواء نجح او فشل 
