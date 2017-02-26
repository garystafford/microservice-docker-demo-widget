#!/bin/sh

set -e

  widgets=( "{\"product_id\":\"RTHGP1FCGN\",\"name\":\"Reflupper\",\"color\":\"Red\",\"size\":\"Large\",\"price\":30,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/RTHGP1FCGN.png\"}"
  "{\"product_id\":\"SVHXPAWEOD\",\"name\":\"Voonex\",\"color\":\"Green\",\"size\":\"Medium\",\"price\":12,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/SVHXPAWEOD.png\"}"
  "{\"product_id\":\"GKO1SFX04M\",\"name\":\"Jukelox\",\"color\":\"Blue\",\"size\":\"Small\",\"price\":7,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/GKO1SFX04M.png\"}"
  "{\"product_id\":\"3YIRGZ6TDW\",\"name\":\"Groopster\",\"color\":\"Yellow\",\"size\":\"Large\",\"price\":35,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/3YIRGZ6TDW.png\"}"
  "{\"product_id\":\"4OZNPBMIDR\",\"name\":\"Fapster\",\"color\":\"Orange\",\"size\":\"Medium\",\"price\":10,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/4OZNPBMIDR.png\"}"
  "{\"product_id\":\"6T2HC5MIZ9\",\"name\":\"Chaintwist\",\"color\":\"Purple\",\"size\":\"Tiny\",\"price\":3,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/6T2HC5MIZ9.png\"}"
  "{\"product_id\":\"ERZ1RMJFR3\",\"name\":\"Glozzom\",\"color\":\"Tan\",\"size\":\"Huge\",\"price\":50,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/ERZ1RMJFR3.png\"}"
  "{\"product_id\":\"0BVCLPDZ42\",\"name\":\"Chaintwist\",\"color\":\"Blue\",\"size\":\"Medium\",\"price\":12,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/0BVCLPDZ42.png\"}"
  "{\"product_id\":\"N43WV5234S\",\"name\":\"Zapster\",\"color\":\"Green\",\"size\":\"Tiny\",\"price\":3,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/N43WV5234S.png\"}"
  "{\"product_id\":\"N212QZOD9B\",\"name\":\"Pentwist\",\"color\":\"Gray\",\"size\":\"Huge\",\"price\":75,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/N212QZOD9B.png\"}"
  "{\"product_id\":\"9D76X1X0LQ\",\"name\":\"Dododox\",\"color\":\"Pink\",\"size\":\"Small\",\"price\":4,\"inventory\":5,\"preview\":\"https://s3.amazonaws.com/widgets-microservice-demo/9D76X1X0LQ.png\"}"
)

for widget in ${widgets[@]}
do
  curl -S -s -H "Content-Type: application/json" \
    -X POST -d ${widget} \
    "http://${WIDGET_SERVICE:localhost}:8030/widgets" \
    > /dev/null
    echo "new widget posted..."
done

echo "Script completed..."
