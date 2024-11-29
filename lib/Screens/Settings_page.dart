import 'package:flutter/material.dart';
import 'package:mobile_gmf/Screens/about_page.dart';
import 'package:mobile_gmf/Screens/signIn_page.dart';
import 'package:mobile_gmf/Theme.dart';
import 'package:mobile_gmf/Screens/dashboard_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_gmf/Screens/gantipasswordpage.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  logout() async {
    // Show the logout notification before removing preferences
    _showLogoutNotification();

    // Remove saved data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Menghapus semua data terkait sesi pengguna
    await prefs.remove('token');   // Token
    await prefs.remove('name');    // Nama pengguna
    await prefs.remove('email');   // Email pengguna
    await prefs.remove('user_id'); // Jika ada, ID pengguna

    // Navigate to the SignInPage after logout
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
      (route) => false, // Pastikan halaman login menggantikan semua halaman sebelumnya
    );
  }


  toAbout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => aboutPage()),
    );
  }

  void _showLogoutNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Anda telah logout'),
        backgroundColor: Colors.orange,
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text('Pengaturan Lainnya',
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 34,
                    width: 100,
                    // color: greenColor,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greenColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: greenColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Akun',
                          style: whitekTextStyle.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: toAbout,
                    child: Container(
                      height: 34,
                      width: 100,
                      // color: greenColor,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: greyColor.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tentang Aplikasi',
                            style: greyTextStyle.copyWith(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 340.0,
                child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    height: 149,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor.withOpacity(0.25),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 76,
                          width: 76,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/profile_image2.png')),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Gumukmas Admin',
                              style: blackTextStyle.copyWith(
                                  fontSize: 13, fontWeight: bold),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Karyawan',
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: light),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.call),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '+6285745616430',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.mail),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'admin@gmail.com',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(),
                    Container(
                      height: 20,
                      width: 20,
                      child: Icon(Icons.lock),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Ganti Password',
                      style: greyTextStyle.copyWith(
                          fontSize: 11, fontWeight: light),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10), // Tambahkan margin kanan untuk ikon
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  GantiPassword(), // Ganti dengan halaman Anda
                            ),
                          );
                        },
                        child: Icon(Icons.chevron_right,
                            size: 20, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: logout,
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: greyColor.withOpacity(0.25),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/logout.png')),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Logout',
                        style: redTextStyle.copyWith(
                            fontSize: 11, fontWeight: light),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
