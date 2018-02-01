# koto-stack

kotodとcpuminer-yescryptを手軽に試すための Docker stack です。

`Docker version 17.12.0-ce, build c97c6d6` で動作確認しています。

# 利用方法

## 事前準備

https://docs.docker.com/engine/installation/linux/docker-ce に従ってDockerをインストールしておきます。

初回起動時、コンテナ中で利用するSSHの公開鍵と秘密鍵を Docker secrets に登録します。

```
sh ./command.sh secret create
```

## 起動

起動します。kotodがブロックチェーンの同期を開始します。

```
sh ./command.sh deploy
```

## 終了

終了します。

```
./command.sh rm
```

## ブロックチェーンの同期

初回起動後、ブロックチェーンの同期が実行されます。これにはけっこうな時間がかかります。

ブロックチェーンの同期が終了したことを確認するためには、blocksとheadersの値を見ます。

```
sh ./command.sh blocks_headers
```

ブロックチェーンの同期が終了したとき、blocksの数がheadersの数と一緒になります。

```
[root@koto-vm koto-stack]# sh ./command.sh blocks_headers
  "blocks": 71840,
  "headers": 71840,
```

## ウォレットの作成

同期が終了したら、ウォレットのアドレスを新規作成します。
既にウォレットのアドレスを持っている人は飛ばしてください。

```
sh ./command.sh getnewaddress
```

ウォレットのアドレスが表示されます。

```
k12zDHEzfpWdHDegbbQ6Eo827fa3mLyuJvv
```

ウォレットのアドレスの秘密鍵を表示します。

```
./command.sh dumpprivkey k12zDHEzfpWdHDegbbQ6Eo827fa3mLyuJvv
```

ウォレットの残高を確認します。

```
./command.sh getbalance
```

## ウォレットの指定

採掘報酬を入れるウォレットのアドレスを設定します。
`docker-compose.yml` のアドレスを指定している部分を編集します。

```
--coinbase-addr=k12zDHEzfpWdHDegbbQ6Eo827fa3mLyuJvv
```

ウォレットのアドレスを設定したら、編集結果を反映するため、stackを再デプロイします。

```
sh ./command.sh deploy
```
