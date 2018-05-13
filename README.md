ローカルにデータを落としてくる:

```
$ heroku pg:backups capture --app feeeed
$ heroku pg:backups --app feeeed
$ curl -o db/latest.dump $(heroku pg:backups public-url b001 --app feeeed)
```

落としたデータをdbに入れる:

```
$ pg_restore --verbose --clean --no-acl --no-owner -h localhost -d feeeed_v2_development db/latest.dump
```
