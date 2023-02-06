import 'package:fitness_app_okul/model/kayit_model.dart';
import 'package:fitness_app_okul/sabit/mail_textfild.dart';
import 'package:fitness_app_okul/sabit/renkler.dart';
import 'package:fitness_app_okul/sabit/sifre_textfild.dart';
import 'package:fitness_app_okul/sayfalar/kaydolma.dart';
import 'package:fitness_app_okul/sayfalar/secim.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:get/route_manager.dart';

class GirisSayfasi extends StatefulWidget {
  const GirisSayfasi({super.key});

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  var mailController = TextEditingController();
  var sifreController = TextEditingController();

  var kayitBox = Hive.box<KayitModel>('kaydolmaDB');

  List<KayitModel> kayitliKullaniciListesi = [];

  @override
  void initState() {
    super.initState();
    for (var element in kayitBox.values) {
      kayitliKullaniciListesi.add(element);
    }
  }

  Row kaydolma() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Get.to(const KaydolmaEkrani());
            },
            child: Text(
              'Kaydol',
              style: TextStyle(color: RenkManeger.genelRenk),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: Get.width / 2,
                width: Get.width / 2,
                child: Lottie.asset('asset/lotti/giris.json')),
            MailTextFild(controller: mailController, label: 'Mail'),
            SifreTextFild(controller: sifreController, label: 'Sifre'),
            kaydolma(),
            const SizedBox(height: 15),
            SizedBox(
                width: Get.width / 2,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {});
                      if (kayitBox.isNotEmpty) {
                        for (var element in kayitBox.values) {
                          if (mailController.text == element.mail &&
                              sifreController.text == element.sifre) {
                            Get.to(const SecimSayfasi());
                            break;
                          } else {}
                        }
                      } else {
                        Get.snackbar('Hata', 'Sistemde hiç kayıt bulunamadı !',
                            backgroundColor: RenkManeger.genelRenk);
                      }
                    },
                    child: const Text('Giriş')))
          ],
        ),
      )),
    );
  }
}
