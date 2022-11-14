part of '../pages.dart';

class CreateNfcPage extends StatelessWidget {
  final Patient patient;
  final isFromDetailPatient;
  const CreateNfcPage(
      {Key? key, required this.patient, this.isFromDetailPatient = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isFromDetailPatient
            ? Navigator.pop(context)
            : AppAlertDialog(
                title: 'Skip Pembuatan Kartu',
                description:
                    'Apakah anda yakin ingin melewati proses ini? Anda tetep bisa membuat kartu untuk pasien ini melelalui halaman detail pasien.',
                positiveButtonText: 'Ya',
                positiveButtonOnTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage()),
                      (Route<dynamic> route) => false);
                },
                negativeButtonText: 'Tidak',
                negativeButtonOnTap: () =>
                    Navigator.pop(context)).show(context);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: 20, top: (MediaQuery.of(context).size.height / 8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Buat kartu NFC Pasien",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Tempelkan kartu, lalu tekan \"Buat Kartu\"",
                  style: TextStyle(
                    color: AppColor.greyFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(child: Image.asset("assets/manage-order.png")),
                Text(
                  "Pastikan fitur NFC mu menyala!",
                  style: TextStyle(
                    color: AppColor.greyFont,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  width: double.infinity,
                  child: BaseButton(
                    style: AppButtonStyle.secondary,
                    border: BorderSide(color: AppColor.primary),
                    radius: 8,
                    padding: 16,
                    isDisabled: false,
                    text: "Buat kartu",
                    onPressed: () async {
                      print(patient.toJson());
                      progressDialogFull(context);
                      bool isNFCAvailable =
                          await NfcManager.instance.isAvailable();
                      print(isNFCAvailable);

                      if (isNFCAvailable) {
                        _ndefWrite(context, patient);
                      } else {
                        dismissProgressDialogFull(context);
                        AppAlertDialog(
                                title: 'Pesan',
                                description:
                                    'Device Anda tidak memiliki fitur NFC!',
                                negativeButtonText: isFromDetailPatient
                                    ? "Tutup"
                                    : 'Skip Pembuatan',
                                negativeButtonOnTap: () => isFromDetailPatient
                                    ? Navigator.pop(context)
                                    : Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()),
                                        (Route<dynamic> route) => false))
                            .show(context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _ndefWrite(BuildContext context, Patient patient) {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      String result;
      print(tag.data);
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result);
        dismissProgressDialogFull(context);
        AppAlertDialog(
            title: 'Pesan',
            description: 'Tag is not ndef writable!',
            negativeButtonText: 'Tutup',
            negativeButtonOnTap: () => Navigator.pop(context)).show(context);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('-${patient.username}-${patient.password}'),
      ]);
      print('Hasil: ${message.records[0]}');
      try {
        await ndef.write(message);
        result = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
        dismissProgressDialogFull(context);
        AppAlertDialog(
            title: 'Selamat!',
            description: 'Kartu NFC berhasil dibuat!',
            negativeButtonText: 'Tutup',
            negativeButtonOnTap: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
                (Route<dynamic> route) => false)).show(context);
      } catch (e) {
        result = e.toString();
        NfcManager.instance.stopSession(errorMessage: result.toString());
        dismissProgressDialogFull(context);
        AppAlertDialog(
            title: 'Pesan',
            description: result,
            negativeButtonText: 'Tutup',
            negativeButtonOnTap: () => Navigator.pop(context)).show(context);
        return;
      }
    });
  }
}
