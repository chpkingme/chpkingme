#!/usr/bin/env bash
set -euo pipefail
UA='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/140 Safari/537.36'
OUT=rf22-public-source-reachability.csv
printf 'id,platform,http_code,size_download,content_type,effective_url\n' > "$OUT"
probe(){
  id="$1"; platform="$2"; url="$3"
  line="$(curl -L -sS --compressed --connect-timeout 12 --max-time 35 -A "$UA" -o /tmp/body.bin -w '%{http_code},%{size_download},%{content_type},%{url_effective}' "$url" || true)"
  printf '%s,%s,%s\n' "$id" "$platform" "$line" >> "$OUT"
}
probe fanqie-rank-718 fanqie https://fanqienovel.com/rank/1_1_718
probe qimao-male-hot-month qimao https://www.qimao.com/paihang/boy/hot/month/
probe qimao-female-hot-month qimao https://www.qimao.com/paihang/girl/hot/month/
probe qimao-modern-ceo-50p qimao https://www.qimao.com/shuku/1-1-8-3-a-a-a-click-1/
probe qimao-modern-ceo-30-50 qimao https://www.qimao.com/shuku/1-1-8-2-a-a-a-click-1/
probe qidian-monthly-ticket qidian https://www.qidian.com/rank/yuepiao/
probe qidian-hotsales qidian https://www.qidian.com/rank/hotsales/
probe qidian-newsign qidian https://www.qidian.com/rank/newsign/
probe zhihu-salt-rank zhihu_yanxuan https://www.zhihu.com/xen/market/ranking-list/salt
probe zhihu-salt-rank-public-fallback zhihu_yanxuan https://www.zhihu.com/xen/market/salt-ranking-list
probe zhihu-salt-rank-legacy-fallback zhihu_yanxuan 'https://www.zhihu.com/xen/market/new-salt-ranking-list?zh_hide_nav_bar=true'
probe heiyan-all-popularity heiyan https://www.heiyan.com/all/-1_-1_1_-1_3_1.html
probe xiaoxiang-rank xiaoxiang https://www.xxsy.net/rank
probe xiaoxiang-new-rank xiaoxiang https://www.xxsy.net/rank/new
probe 17k-top 17k https://www.17k.com/top/
cat "$OUT"
