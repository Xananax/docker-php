<html>
    <body>
    <h1>Hello World</h1>
    <p>
        It seems your docker is working. Edit files in <br/>
        <a href="file://%DOCUMENT_DIR%">%DOCUMENT_DIR%</a> to get started
    </p><p>
        Your databases are in:<br/>
        <a href="file://%DATA_DIR%">%DATA_DIR%</a>
    </p><p>
        You can access the files in your host on port `<a href="http://localhost:%PORT_HOST%">http://localhost:%PORT_HOST%</a>`
    </p>
    <hr/>
    <p>
        if you can read the below, php works:
    </p><p>
        <?php echo "local directory inside the container: ".__DIR__ ?>
    </p>
    <p>
        <h2>testing databases</h2>
        <ul>
<?php

$PGSQL_USER="%PGSQL_USER%";
$PGSQL_PASSWORD="%PGSQL_PASSWORD%";
$MYSQL_USER="%MYSQL_USER%";
$MYSQL_PASSWORD="%MYSQL_PASSWORD%";


function title($n){
    echo "<li><h3>$n</h3></li>";
}

function success($n,$z){
    echo "<li>$n is enabled$zi</li>";
}
function failure($n,$z){
    echo "<li>$n is disabled$z</li>";
}

function test($name,$host,$user,$pass){
    title("PDO:$name");
    echo "<ul>";
    try{
        if($user){
            $dsn="$name:host=$host;user=$user;password=$pass";
            new PDO($dsn,$user,$pass);
            success($name, "on `$host` with `$user` and `$pass`");
        }else{
            $dsn="$name:$host";
            new PDO($dsn);
            success($name,"as `$host`");
        }
    }catch(PDOException $e){
        failure($name,': '.$e->getMessage());
    }
    echo "</ul>";
}

test('sqlite',":memory",'','');
test('mysql','%MYSQL_CONTAINER_NAME%:3306',$MYSQL_USER,$MYSQL_PASSWORD);
test('pgsql','%PGSQL_CONTAINER_NAME%:5432',$PGSQL_USER,$PGSQL_PASSWORD);

?>
        </ul>
    </p>
    <hr/>
    <br/>
    <h2>PHP Info Here</h2>
    <?php phpinfo();?>
    </body>
</html>
