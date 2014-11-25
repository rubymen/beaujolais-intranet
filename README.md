# Beaujolais Intranet
## Bootstrap app

cd config && cp database.yml{.sample,} && cd -

## Regenerate database

rake db:drop; rake db:create; rake db:migrate
