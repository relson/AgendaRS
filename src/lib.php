<?php

function connect() {
    $conn = mysqli_connect("127.0.0.1", "root", "root");
    mysqli_select_db($conn, "agendars");
    return $conn;
}

function sqlvalue($val, $quote) {
    if ($quote)
        $tmp = sqlstr($val);
    else
        $tmp = $val;
    if ($tmp == "")
        $tmp = "NULL";
    elseif ($quote)
        $tmp = "'" . $tmp . "'";
    return $tmp;
}

function sqlstr($val) {
    if ($val == null) {
        return '';
    }
    return str_replace("'", "''", $val);
}