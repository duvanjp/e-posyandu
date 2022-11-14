part of 'pages.dart';

class NFCPage extends StatefulWidget {
  NFCPage({Key? key}) : super(key: key);

  @override
  State<NFCPage> createState() => _NFCPageState();
}

class _NFCPageState extends State<NFCPage> {
  late PatientCubit patientCubit;

  @override
  void initState() {
    patientCubit = BlocProvider.of<PatientCubit>(context);
    super.initState();
  }

  void _tagRead() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      NdefMessage? message = await ndef?.read();
      NdefRecord? value = message?.records[0];

      List<int> list = value!.payload;
      Uint8List bytes = Uint8List.fromList(list);
      String string = String.fromCharCodes(bytes);
      print(string);
      if (string.contains('-')) {
        String username = string.split('-')[1];
        String password = string.split('-')[2];
        print("username:$username | password:$password");

        patientCubit.readData(username, password);
      } else {
        dismissProgressDialogFull(context);
        AppAlertDialog(
            title: 'Pesan',
            description: 'Kartu NFC tidak valid!',
            negativeButtonText: 'Tutup',
            negativeButtonOnTap: () => Navigator.pop(context)).show(context);
      }

      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientCubit, PatientState>(
      listener: (context, state) {
        if (state is ReadDataSuccess) {
          dismissProgressDialogFull(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      CatatanPage(patient: state.patient)));
        } else if (state is ReadDataFailed) {
          dismissProgressDialogFull(context);
          AppAlertDialog(
              title: 'Pesan',
              description: 'Pasien tidak ditemukan!',
              negativeButtonText: 'Tutup',
              negativeButtonOnTap: () => Navigator.pop(context)).show(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: Text(
            "Baca Data Pasien",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          automaticallyImplyLeading: false,
          elevation: 1,
        ),
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  shape: const CircleBorder(),
                  onPressed: () async {
                    progressDialogFull(context);
                    bool isNFCAvailable =
                        await NfcManager.instance.isAvailable();
                    print(isNFCAvailable);

                    if (isNFCAvailable) {
                      _tagRead();
                    } else {
                      dismissProgressDialogFull(context);
                      AppAlertDialog(
                          title: 'Pesan',
                          description: 'Device Anda tidak memiliki fitur NFC!',
                          negativeButtonText: 'Tutup',
                          negativeButtonOnTap: () =>
                              Navigator.pop(context)).show(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(100),
                    child: Text(
                      'Baca Kartu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Pastikan fitur NFC pada device Anda menyala!',
                  style: TextStyle(fontSize: 14, color: AppColor.darkGrey),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }
}
