part of '../pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Selamat Datang di E-Posyandu!",
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
                "Catat Datamu setiap hari",
                style: TextStyle(
                  color: AppColor.greyFont,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Expanded(child: Image.asset("assets/manage-order.png")),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                width: double.infinity,
                child: BaseButton(
                  style: AppButtonStyle.primary,
                  radius: 8,
                  padding: 16,
                  isDisabled: false,
                  text: "Masuk",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()));
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: BaseButton(
                  style: AppButtonStyle.secondary,
                  border: BorderSide(color: AppColor.primary),
                  radius: 8,
                  padding: 16,
                  isDisabled: false,
                  text: "Mendaftar",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegisterPage()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
