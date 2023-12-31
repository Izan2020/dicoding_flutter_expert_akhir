# Dicoding Flutter Expert

![wow](https://github.com/Izan2020/dicoding_flutter_expert_akhir/assets/59131023/4fb26c5d-71fb-4114-b475-4f03c963e0f4)


Repository ini merupakan starter project submission kelas Flutter Expert Dicoding Indonesia.
<br/>[![Codemagic build status](https://api.codemagic.io/apps/6506d403803811abcc185ff4/6506d403803811abcc185ff3/status_badge.svg)](https://codemagic.io/apps/6506d403803811abcc185ff4/6506d403803811abcc185ff3/latest_build)

---



## Code Magic Build

<img width="1053" alt="image" src="https://github.com/Izan2020/dicoding_flutter_expert_akhir/assets/59131023/48f05606-0fd0-4424-87e8-243678425e64">
<img width="1284" alt="Screenshot 2023-09-18 at 12 12 00" src="https://github.com/Izan2020/dicoding_flutter_expert_akhir/assets/59131023/e946c3a3-7ee8-42f5-b0c9-1f55376f4232">



---

## Firebase Crashlytics

<img width="1284" alt="Screenshot 2023-09-18 at 12 02 30" src="https://github.com/Izan2020/dicoding_flutter_expert_akhir/assets/59131023/a0f43d60-152c-48ab-b4a3-08387a107132">
<img width="1284" alt="Screenshot 2023-09-18 at 12 07 23" src="https://github.com/Izan2020/dicoding_flutter_expert_akhir/assets/59131023/b6693df6-ff1a-4518-8a8d-6db6902d7e39">


---

## Tips Submission Awal

Pastikan untuk memeriksa kembali seluruh hasil testing pada submissionmu sebelum dikirimkan. Karena kriteria pada submission ini akan diperiksa setelah seluruh berkas testing berhasil dijalankan.


## Tips Submission Akhir

Jika kamu menerapkan modular pada project, Anda dapat memanfaatkan berkas `test.sh` pada repository ini. Berkas tersebut dapat mempermudah proses testing melalui *terminal* atau *command prompt*. Sebelumnya menjalankan berkas tersebut, ikuti beberapa langkah berikut:
1. Install terlebih dahulu aplikasi sesuai dengan Operating System (OS) yang Anda gunakan.
    - Bagi pengguna **Linux**, jalankan perintah berikut pada terminal.
        ```
        sudo apt-get update -qq -y
        sudo apt-get install lcov -y
        ```
    
    - Bagi pengguna **Mac**, jalankan perintah berikut pada terminal.
        ```
        brew install lcov
        ```
    - Bagi pengguna **Windows**, ikuti langkah berikut.
        - Install [Chocolatey](https://chocolatey.org/install) pada komputermu.
        - Setelah berhasil, install [lcov](https://community.chocolatey.org/packages/lcov) dengan menjalankan perintah berikut.
            ```
            choco install lcov
            ```
        - Kemudian cek **Environtment Variabel** pada kolom **System variabels** terdapat variabel GENTHTML dan LCOV_HOME. Jika tidak tersedia, Anda bisa menambahkan variabel baru dengan nilai seperti berikut.
            | Variable | Value|
            | ----------- | ----------- |
            | GENTHTML | C:\ProgramData\chocolatey\lib\lcov\tools\bin\genhtml |
            | LCOV_HOME | C:\ProgramData\chocolatey\lib\lcov\tools |
        
2. Untuk mempermudah proses verifikasi testing, jalankan perintah berikut.
    ```
    git init
    ```
3. Kemudian jalankan berkas `test.sh` dengan perintah berikut pada *terminal* atau *powershell*.
    ```
    test.sh
    ```
    atau
    ```
    ./test.sh
    ```
    Proses ini akan men-*generate* berkas `lcov.info` dan folder `coverage` terkait dengan laporan coverage.
4. Tunggu proses testing selesai hingga muncul web terkait laporan coverage.

