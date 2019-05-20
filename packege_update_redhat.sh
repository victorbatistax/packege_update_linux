#!/bin/bash

yum check-update | awk '{print $1}' | sed -e '/^[0-9]/d' > pkg.txt

exitfn () {
    trap SIGINT
    echo; echo ' </tbody>
</table>
</body>
</html>' >> index.html
    exit
}

hostname=`hostname`
echo '
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<title> Atualização de Packeges </title>
<body>
<header>
<h2 align="left" style="margin-left: 10px">EC2 - RCHLO - $hostname</h2>
<img style="margin-top: -50px" align="right" height="114" src="http://dedalus-marketing.s3.amazonaws.com/trade/assinatura-logo.png" width="200" style="user-select: none;" tabindex="0">
</header>
<table class="table">
  <thead class="thead-dark">
    <tr>
      <th scope="col">#</th>
      <th scope="col">Name Packege</th>
      <th scope="col">Informação</th>
      <th scope="col">Fix Bug</th>
    </tr>
  </thead>' > index.html
count=0
FILE="pkg.txt"

for p in $(cat $FILE);
do
    count=$(($count + 1))
    INFO=`yum info $p`
    FIXI=`yum changelog all $p | head -30`

    echo "<tr>
      <th scope="row">$count -</th>
      <td><b>$p</b></td>
      <td><pre>$INFO</pre></td>
      <td><pre style="width: 50%">$FIXI</pre></td>
    </tr>" >> index.html
done

echo ' </tbody>
</table>
</body>
</html>' >> index.html
#trap SIGINT
