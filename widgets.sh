#!/bin/sh

# Create (11) new widget documents into the widget collection of the widgets database
# Script expects the WIDGET_SERVICE environment variable to be set, or defaults to localhost
# WIDGET_SERVICE a hostname or IP address of a running instance of the widget service

set -e

widgets=(
  "{\"product_id\":\"RTHGP1FCGN\",\"name\":\"Reflupper\",\"color\":\"Red\",\"size\":\"Large\",\"price\":30,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"SVHXPAWEOD\",\"name\":\"Voonex\",\"color\":\"Green\",\"size\":\"Medium\",\"price\":12,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"GKO1SFX04M\",\"name\":\"Jukelox\",\"color\":\"Blue\",\"size\":\"Small\",\"price\":7,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"3YIRGZ6TDW\",\"name\":\"Groopster\",\"color\":\"Yellow\",\"size\":\"Large\",\"price\":35,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"4OZNPBMIDR\",\"name\":\"Fapster\",\"color\":\"Orange\",\"size\":\"Medium\",\"price\":10,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"6T2HC5MIZ9\",\"name\":\"Chaintwist\",\"color\":\"Purple\",\"size\":\"Tiny\",\"price\":3,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"ERZ1RMJFR3\",\"name\":\"Glozzom\",\"color\":\"Tan\",\"size\":\"Huge\",\"price\":50,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"0BVCLPDZ42\",\"name\":\"Chaintwist\",\"color\":\"Blue\",\"size\":\"Medium\",\"price\":12,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"N43WV5234S\",\"name\":\"Zapster\",\"color\":\"Green\",\"size\":\"Tiny\",\"price\":3,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"N212QZOD9B\",\"name\":\"Pentwist\",\"color\":\"Gray\",\"size\":\"Huge\",\"price\":75,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
  "{\"product_id\":\"9D76X1X0LQ\",\"name\":\"Dododox\",\"color\":\"Pink\",\"size\":\"Small\",\"price\":4,\"inventory\":5,\"preview\":\"<no_preview_available>\"}"
)

for widget in ${widgets[@]}
do
  curl -S -s -H "Content-Type: application/json" \
    -X POST -d ${widget} \
    "http://${WIDGET_SERVICE:localhost}:8030/widgets" \
    > /dev/null
    echo "New widget posted..."
done

echo "Script completed..."
