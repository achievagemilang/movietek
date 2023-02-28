
<img src="/assets/ic_launcher.png" width="100" height="100">


# MovieTek
<hr/>

## _Review Film Favoritmu!_

> MovieTek adalah sebuah aplikasi untuk melihat film-film / TV series yang sedang trending, upcoming, ataupun yang sedang tayang sekarang. Aplikasi ini memanfaatkan TMDB API dalam pengimplementasian fiturnya. Pada aplikasi ini juga diterapkan SharedPreferences sehingga hal yang user lakukan akan tersimpan pada local device user.


#### Powered by:
<img src="/assets/tmdb.png" width="120" height="80">


<hr/>

<br/>


## Features

- **Main Page**

<p align= "center">
<img src="/assets/readme/mainpage.jpg" width="500" height="400">
</p>

Menampilkan movies yang telah diperoleh dari response API ke UI aplikasi. Movies ditampilkan based on tiga kategori; Upcoming, Trending, dan Now Playing. User juga dapat melihat detail page dari setiap movies tersebut. Melalui Main Page, kita juga dapat menuju Profile Page dengan mengklik gambar avatar dari user. Selain itu, terdapat navigasi untuk menuju Loved List Page dengan cara mengklik icon hamburger bar (list), Pada gambar diatas, kita dapat melihat tampilan interface Main Page sebelum dan sesudah mengedit profile.

<br/>

- **Movie Detail Page**

<p align= "center">
<img src="/assets/readme/moviedetail.jpg" width="500" height="400">
</p>

Menampilkan detail dari movie yang ditampilkan pada bagian Main Page. Pada Movie Detail Page, user dapat melihat overview beserta cast list dari movie tersebut. Terdapat pula tombol like untuk menambahkan movie ke daftar list movie yang kita sukai. Overview movie dikemas dalam bentuk expandable text. 

<br/>

- **Profile Page**

<p align= "center">
<img src="/assets/readme/profile.jpg" width="500" height="400">
</p>

Halaman ini berisikan profile picture dan identitas diri dari user, seperti nama lengkap, nama panggilan, jurusan, hobi, media sosial, dan bio singkat dari user. User juga dapat mengedit Profile Page nya dengan cara menekan text Edit Profile pada interface aplikasi. Fitur ini juga telah dilengkapi SharedPreferences sehingga modifikasi yang dilakukan user akan tersimpan untuk penggunaan next launch aplikasi. Pada gambar diatas, dapat dilihat default profile page saat user meluncurkan aplikasi dan ketika user telah mengedit Profile Page-nya. 

<br/>

- **Edit Profile Page**

<p align= "center">
<img src="/assets/readme/editprofile.jpg" width="500" height="400">
</p>

Fitur ini adalah fitur yang memungkinkan user melakukan modifikasi terhadap Profile Page user pada aplikasi ini. Melalui fitur ini, user dapat mengubah profile picture dan mengedit informasi pribadinya seperti nama lengkap, nama panggilan, jurusan, hobi, media sosial, dan short bio. Pada gambar diatas adalah contoh tampilan aplikasi user sebelum dan sesudah mengedit Profile Page-nya.

<br/>

- **Loved List Page**

<p align= "center">
<img src="/assets/readme/lovedlist.jpg" width="200" height="400">
</p>

Fitur ini menampilkan list movie yang telah ditambahkan/ditandai sebagai favorit dari user. List movie disimpan dan ditampilkan dalam bentuk Card pada interface aplikasi. Melalui Card tersebut, user juga dapat berpindah ke Movie Detail Page untuk melihat kembali film yang disukainya. Tersedia pula tombol refresh untuk me-refresh page ketika user selesai melakukan modifikasi (love/unlove movie).

<br/>



## Package Dependency

MovieTek membutuhkan additional package dalam pengembangannya. Berikut adalah list package tersebut:

- [tmdb_api] - Mendapatkan data movies / tv series dari TMDB API
- [image_picker] - Mendapatkan image dari gallery user sebagai profile image user
- [path_provider] - Memanfaatkan `getApplicationDocumentsDirectory()` untuk mendapat path direktori image
- [shared_preferences] - Memberikan local storage pada aplikasi sehingga aksi user dapat terekam
- [path] - Memanfaatkan method `basename()` untuk mendapatkan endpoint dari path direktori image 
- [intl] - Formatting date untuk release date atau first air date suatu movies / tv series

<br/>

[//]: # (!!  Reference Link  !!)

   [tmdb_api]: <https://pub.dev/packages/tmdb_api>
   [image_picker]: <https://pub.dev/packages/image_picker>
   [path]: <https://pub.dev/packages/path>
   [path_provider]: <https://pub.dev/packages/path_provider>
   [shared_preferences]: <https://pub.dev/packages/shared_preferences>
   [intl]: <https://pub.dev/packages/intl>
