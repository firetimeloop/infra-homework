#!/bin/bash

export LANG=C.UTF-8

echo "Создание заголовков для запроса заполнения релизного тикета"
headerAuthorization="Authorization: OAuth ${AUTH_TOKEN}"
headerXOrgId="X-Org-ID: ${X_ORG_ID}"

echo "Поиск последних релизных тегов"

echo "$(git tag --sort=committerdate)"
lastTag="$(git tag --sort=committerdate | grep -E 'rc-0.0.[0-9]+' | tail -1)"
previousTag="$(git tag --sort=committerdate | grep -E 'rc-0.0.[0-9]+' | tail -2)"
echo "${previousTag} ${lastTag}"
echo "$(git log ${previousTag}..${lastTag})"

echo "Создание тела для запроса заполнения релизного тикета"
commits="$(git log ${previousTag}..${lastTag} --pretty=format:"%h | %an | %s")"
echo "${commits}"

requestData()
{
cat << EOF
{
	"summary": "Релиз ${lastTag} - $(date +%D)",
	"description": "ответственный за релиз: ${ACTOR}\nкоммиты, попавшие в релиз:\n${commits}"
}
EOF
}
