
## heroku db backups

```
$ heroku pg:backups capture --app feeeed
$ heroku pg:backups --app feeeed
$ curl -o db/latest.dump $(heroku pg:backups public-url b007 --app feeeed)
```

## backups -> local

```
$ pg_restore --verbose --clean --no-acl --no-owner -h localhost -d feeeed_v2_development db/latest.dump
```

## local -> heroku

```
$ heroku pg:reset HEROKU_POSTGRESQL_ROSE_URL --app feeeed
$ feeeed
$ heroku pg:push feeeed_v2_development HEROKU_POSTGRESQL_ROSE_URL --app feeeed
```

`HEROKU_POSTGRESQL_ROSE_URL`
`HEROKU_POSTGRESQL_WHITE_URL`

## 動かなくなった時

```
$ bundle exec rake db:drop db:create db:migrate
```
