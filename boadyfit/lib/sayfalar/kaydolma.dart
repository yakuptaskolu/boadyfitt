import 'package:fitness_app_okul/sabit/renkler.dart';
import 'package:fitness_app_okul/sayfalar/giris_sayfasi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/kayit_model.dart';
import '../sabit/mail_textfild.dart';
import '../sabit/sifre_textfild.dart';
import 'package:uuid/uuid.dart';

class KaydolmaEkrani extends StatefulWidget {
  const KaydolmaEkrani({super.key});

  @override
  State<KaydolmaEkrani> createState() => _KaydolmaEkraniState();
}

class _KaydolmaEkraniState extends State<KaydolmaEkrani> {
  var mailController = TextEditingController();
  var sifreController = TextEditingController();
  var kayitBox = Hive.box<KayitModel>('kaydolmaDB');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MailTextFild(controller: mailController, label: 'Mail'),
            SifreTextFild(controller: sifreController, label: 'Sifre'),
            const SizedBox(height: 15),
            SizedBox(
                width: Get.width / 2,
                child: ElevatedButton(
                    onPressed: () {
                      if (mailController.text.isNotEmpty &&
                          sifreController.text.isNotEmpty) {
                        var id = const Uuid().v1();
                        var kaydolacakVeri = KayitModel(
                            mail: mailController.text,
                            sifre: sifreController.text,
                            id: id);
                        kayitBox.put(id, kaydolacakVeri);
                        mailController.clear();
                        sifreController.clear();
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const GirisSayfasi(),
                            ),
                            (route) => false);
                      } else {
                        Get.snackbar('Uyarı',
                            'Tüm alanların dolu olduğuna emin olduktan sonrqa tekrar dene.',
                            backgroundColor: RenkManeger.genelRenk);
                      }
                    },
                    child: const Text('Kaydol')))
          ],
        ),
      ),
    );
  }
}
