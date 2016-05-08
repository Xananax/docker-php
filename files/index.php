<html>
    <body>
    <p>
        Hello World! Your docker is working. Edit files in <br/>
        <a href="file://%HOST_DIR%">%HOST_DIR%</a> to get started<br/>
        Your databases are in:<br/>
        <a href="file://%DATA_HOST_DIR%">%DATA_HOST_DIR%</a><br/>
    </p>
    <p>
        if you can read the below, php works:
    </p>
    <p>
        <?php echo "local directory inside the container: ".__DIR__ ?>
    </p>
    <p>
    <h2>testing databases</h2>
    <ul>
<?php

$POSTGRES_USER="%POSTGRES_USER%";
$POSTGRES_PASSWORD="%POSTGRES_PASSWORD%";
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
    echo "<ul>--";
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
test('mysql','%DATABASE_CONTAINER_MYSQL_NAME%:3306',$MYSQL_USER,$MYSQL_PASSWORD);
test('pgsql','%DATABASE_CONTAINER_PGSQL_NAME%:5432',$POSTGRES_USER,$POSTGRES_PASSWORD);

?>
    </ul>
    </p>
    <?php phpinfo();?>
    </body>
</html>
