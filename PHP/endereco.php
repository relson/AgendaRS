<?php
session_start();

require_once 'lib.php';

if (isset($_GET["order"]))
    $order = @$_GET["order"];
if (isset($_GET["type"]))
    $ordtype = @$_GET["type"];

if (isset($_POST["filter"]))
    $filter = @$_POST["filter"];
if (isset($_POST["filter_field"]))
    $filterfield = @$_POST["filter_field"];
$wholeonly = false;
if (isset($_POST["wholeonly"]))
    $wholeonly = @$_POST["wholeonly"];

if (!isset($order) && isset($_SESSION["order"]))
    $order = $_SESSION["order"];
if (!isset($ordtype) && isset($_SESSION["type"]))
    $ordtype = $_SESSION["type"];
if (!isset($filter) && isset($_SESSION["filter"]))
    $filter = $_SESSION["filter"];
if (!isset($filterfield) && isset($_SESSION["filter_field"]))
    $filterfield = $_SESSION["filter_field"];
?>

<html>
    <head>
        <title>AgendaRS - [Endere&ccedil;o]</title>
        <meta name="generator" http-equiv="content-type" content="text/html" charset="ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table class="bd" width="100%"><tr><td class="hr"><h2>AgendaRS - [Endere&ccedil;o]</h2></td></tr></table>
        <table width="100%">
            <tr>

                <td width="10%" valign="top">
                    <h3>Cadastro</h3>
            <li><a href="contato.php?a=reset">Contato</a>
            <li><a href="telefone.php?a=reset">Telefone</a>
            <li><a href="email.php?a=reset">e-mail</a>
            <li>Endere&ccedil;o
            <li><a href="tarefa.php?a=reset">Tarefa</a>
                <h3>Tipos</h3>
            <li><a href="tipocontato.php?a=reset">Contato</a>
            <li><a href="tipoemail.php?a=reset">e-mail</a>
            <li><a href="tipoendereco.php?a=reset">Endere&ccedil;o</a>
            <li><a href="tipotelefone.php?a=reset">Telefone</a>
                <h3>Associar ao Contato</h3>
            <li><a href="contatoemails.php?a=reset">e-mail</a>
            <li><a href="contatoenderecos.php?a=reset">Endere&ccedil;o</a>
            <li><a href="contatotelefones.php?a=reset">Telefone</a>
            <li><a href="contatotipos.php?a=reset">Tipo de Contato</a>
                <h3>Configura&ccedil;&atilde;o Tarefa</h3>
            <li><a href="tarefaprioridade.php?a=reset">Prioridade</a>
            <li><a href="tarefastatus.php?a=reset">Status</a>
                </td>
            <td width="5%">
            </td>
            <td bgcolor="#e0e0e0">
            </td>
            <td width="5%">
            </td>
            <td width="80%" valign="top">
                <?php
                $conn = connect();
                $showrecs = 20;
                $pagerange = 10;

                $a = @$_GET["a"];
                $recid = @$_GET["recid"];
                $page = @$_GET["page"];
                if (!isset($page))
                    $page = 1;

                $sql = @$_POST["sql"];

                switch ($sql) {
                    case "insert":
                        sql_insert();
                        break;
                    case "update":
                        sql_update();
                        break;
                    case "delete":
                        sql_delete();
                        break;
                }

                switch ($a) {
                    case "add":
                        addrec();
                        break;
                    case "view":
                        viewrec($recid);
                        break;
                    case "edit":
                        editrec($recid);
                        break;
                    case "del":
                        deleterec($recid);
                        break;
                    default:
                        select();
                        break;
                }

                if (isset($order))
                    $_SESSION["order"] = $order;
                if (isset($ordtype))
                    $_SESSION["type"] = $ordtype;
                if (isset($filter))
                    $_SESSION["filter"] = $filter;
                if (isset($filterfield))
                    $_SESSION["filter_field"] = $filterfield;
                if (isset($wholeonly))
                    $_SESSION["wholeonly"] = $wholeonly;

                mysqli_close($conn);
                ?>
            </td></tr></table>
    <table class="bd" width="100%"><tr><td class="hr">Todos os direitos reservados</td></tr></table>
</body>
</html>

<?php

function select() {
    global $a;
    global $showrecs;
    global $page;
    global $filter;
    global $filterfield;
    global $wholeonly;
    global $order;
    global $ordtype;


    if ($a == "reset") {
        $filter = "";
        $filterfield = "";
        $wholeonly = "";
        $order = "";
        $ordtype = "";
    }

    $checkstr = "";
    if ($wholeonly)
        $checkstr = " checked";
    if ($ordtype == "asc") {
        $ordtypestr = "desc";
    } else {
        $ordtypestr = "asc";
    }
    $res = sql_select();
    $count = sql_getrecordcount();
    if ($count % $showrecs != 0) {
        $pagecount = intval($count / $showrecs) + 1;
    } else {
        $pagecount = intval($count / $showrecs);
    }
    $startrec = $showrecs * ($page - 1);
    if ($startrec < $count) {
        mysqli_data_seek($res, $startrec);
    }
    $reccount = min($showrecs * $page, $count);
    ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr><td>Cadastro: endereco</td></tr>
        <tr><td>Exibindo registros <?php echo $startrec + 1 ?> - <?php echo $reccount ?> of <?php echo $count ?></td></tr>
    </table>
    <hr size="1" noshade>
    <form action="endereco.php" method="post">
        <table class="bd" border="0" cellspacing="1" cellpadding="4">
            <tr>
                <td><b>Filtros</b>&nbsp;</td>
                <td><input type="text" name="filter" value="<?php echo $filter ?>"></td>
                <td><select name="filter_field">
                        <option value="">Todos os Campos</option>
                        <option value="<?php echo "codigoEndereco" ?>"<?php
    if ($filterfield == "codigoEndereco") {
        echo "selected";
    }
    ?>><?php echo htmlspecialchars("Codigo") ?></option>
                        <option value="<?php echo "lp_codigoTipoEndereco" ?>"<?php
                            if ($filterfield == "lp_codigoTipoEndereco") {
                                echo "selected";
                            }
    ?>><?php echo htmlspecialchars("Tipo") ?></option>
                        <option value="<?php echo "endereco" ?>"<?php
                            if ($filterfield == "endereco") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Endereco") ?></option>
                    </select></td>
                <td><input type="checkbox" name="wholeonly"<?php echo $checkstr ?>>Coincidir palavras completas</td>
                </td></tr>
            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" name="action" value="Filtrar"></td>
                <td><a href="endereco.php?a=reset">Limpar Filtro</a></td>
            </tr>
        </table>
    </form>
    <hr size="1" noshade>
    <?php showpagenav($page, $pagecount); ?>
    <br>
    <table class="tbl" border="0" cellspacing="1" cellpadding="5"width="100%">
        <tr>
            <td class="hr">&nbsp;</td>
            <td class="hr">&nbsp;</td>
            <td class="hr">&nbsp;</td>
            <td class="hr"><a class="hr" href="endereco.php?order=<?php echo "codigoEndereco" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Codigo") ?></a></td>
            <td class="hr"><a class="hr" href="endereco.php?order=<?php echo "lp_codigoTipoEndereco" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Tipo") ?></a></td>
            <td class="hr"><a class="hr" href="endereco.php?order=<?php echo "endereco" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Endereco") ?></a></td>
        </tr>
        <?php
        for ($i = $startrec; $i < $reccount; $i++) {
            $row = mysqli_fetch_assoc($res);
            $style = "dr";
            if ($i % 2 != 0) {
                $style = "sr";
            }
            ?>
            <tr>
                <td class="<?php echo $style ?>"><a href="endereco.php?a=view&recid=<?php echo $i ?>">Ver</a></td>
                <td class="<?php echo $style ?>"><a href="endereco.php?a=edit&recid=<?php echo $i ?>">Editar</a></td>
                <td class="<?php echo $style ?>"><a href="endereco.php?a=del&recid=<?php echo $i ?>">Excluir</a></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["codigoEndereco"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["lp_codigoTipoEndereco"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["endereco"]) ?></td>
            </tr>
        <?php
    }
    mysqli_free_result($res);
    ?>
    </table>
    <br>
    <?php showpagenav($page, $pagecount); ?>
<?php } ?>

<?php

function showrow($row, $recid) {
    ?>
    <table class="tbl" border="0" cellspacing="1" cellpadding="5"width="50%">
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Codigo") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["codigoEndereco"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Tipo") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["lp_codigoTipoEndereco"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Endereco") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["endereco"]) ?></td>
        </tr>
    </table>
<?php } ?>

<?php

function showroweditor($row, $iseditmode) {
    global $conn;
    ?>
    <table class="tbl" border="0" cellspacing="1" cellpadding="5"width="50%">
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Tipo") . "&nbsp;" ?></td>
            <td class="dr"><select name="codigoTipoEndereco">
                    <?php
                    $sql = "select `codigoTipoEndereco`, `descricao` from `tipoendereco`";
                    $res = mysqli_query($conn, $sql) or die(mysqli_error());

                    while ($lp_row = mysqli_fetch_assoc($res)) {
                        $val = $lp_row["codigoTipoEndereco"];
                        $caption = $lp_row["descricao"];
                        if ($row["codigoTipoEndereco"] == $val) {
                            $selstr = " selected";
                        } else {
                            $selstr = "";
                        }
                        ?><option value="<?php echo $val ?>"<?php echo $selstr ?>><?php echo $caption ?></option>
    <?php } ?></select>
            </td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Endereço") . "&nbsp;" ?></td>
            <td class="dr"><textarea cols="35" rows="4" name="endereco"><?php echo str_replace('"', '&quot;', trim($row["endereco"])) ?></textarea></td>
        </tr>
    </table>
<?php } ?>

        <?php

        function showpagenav($page, $pagecount) {
            ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="endereco.php?a=add">Inserir Registro</a>&nbsp;</td>
            <?php if ($page > 1) { ?>
                <td><a href="endereco.php?page=<?php echo $page - 1 ?>">&lt;&lt;&nbsp;Anterior</a>&nbsp;</td>
            <?php } ?>
            <?php
            global $pagerange;

            if ($pagecount > 1) {

                if ($pagecount % $pagerange != 0) {
                    $rangecount = intval($pagecount / $pagerange) + 1;
                } else {
                    $rangecount = intval($pagecount / $pagerange);
                }
                for ($i = 1; $i < $rangecount + 1; $i++) {
                    $startpage = (($i - 1) * $pagerange) + 1;
                    $count = min($i * $pagerange, $pagecount);

                    if ((($page >= $startpage) && ($page <= ($i * $pagerange)))) {
                        for ($j = $startpage; $j < $count + 1; $j++) {
                            if ($j == $page) {
                                ?>
                                <td><b><?php echo $j ?></b></td>
                            <?php } else { ?>
                                <td><a href="endereco.php?page=<?php echo $j ?>"><?php echo $j ?></a></td>
                            <?php
                            }
                        }
                    } else {
                        ?>
                        <td><a href="endereco.php?page=<?php echo $startpage ?>"><?php echo $startpage . "..." . $count ?></a></td>
            <?php
            }
        }
    }
    ?>
    <?php if ($page < $pagecount) { ?>
                <td>&nbsp;<a href="endereco.php?page=<?php echo $page + 1 ?>">Próximo&nbsp;&gt;&gt;</a>&nbsp;</td>
    <?php } ?>
        </tr>
    </table>
        <?php } ?>

        <?php

        function showrecnav($a, $recid, $count) {
            ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="endereco.php">Pagina Inicial</a></td>
    <?php if ($recid > 0) { ?>
                <td><a href="endereco.php?a=<?php echo $a ?>&recid=<?php echo $recid - 1 ?>">Registro Anterior</a></td>
    <?php } if ($recid < $count - 1) { ?>
                <td><a href="endereco.php?a=<?php echo $a ?>&recid=<?php echo $recid + 1 ?>">Próximo Registro</a></td>
    <?php } ?>
        </tr>
    </table>
    <hr size="1" noshade>
<?php } ?>

<?php

function addrec() {
    ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="endereco.php">Pagina Inicial</a></td>
        </tr>
    </table>
    <hr size="1" noshade>
    <form enctype="multipart/form-data" action="endereco.php" method="post">
        <p><input type="hidden" name="sql" value="insert"></p>
    <?php
    $row = array(
        "codigoEndereco" => "",
        "codigoTipoEndereco" => "",
        "endereco" => "");
    showroweditor($row, false);
    ?>
        <p><input type="submit" name="action" value="Gravar"></p>
    </form>
<?php } ?>

<?php

function viewrec($recid) {
    $res = sql_select();
    $count = sql_getrecordcount();
    mysqli_data_seek($res, $recid);
    $row = mysqli_fetch_assoc($res);
    showrecnav("view", $recid, $count);
    ?>
    <br>
    <?php showrow($row, $recid) ?>
    <br>
    <hr size="1" noshade>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="endereco.php?a=add">Inserir Registro</a></td>
            <td><a href="endereco.php?a=edit&recid=<?php echo $recid ?>">Editar Registro</a></td>
            <td><a href="endereco.php?a=del&recid=<?php echo $recid ?>">Excluir Registro</a></td>
        </tr>
    </table>
    <?php
    mysqli_free_result($res);
}
?>

<?php

function editrec($recid) {
    $res = sql_select();
    $count = sql_getrecordcount();
    mysqli_data_seek($res, $recid);
    $row = mysqli_fetch_assoc($res);
    showrecnav("edit", $recid, $count);
    ?>
    <br>
    <form enctype="multipart/form-data" action="endereco.php" method="post">
        <input type="hidden" name="sql" value="update">
        <input type="hidden" name="xcodigoEndereco" value="<?php echo $row["codigoEndereco"] ?>">
    <?php showroweditor($row, true); ?>
        <p><input type="submit" name="action" value="Gravar"></p>
    </form>
    <?php
    mysqli_free_result($res);
}
?>

<?php

function deleterec($recid) {
    $res = sql_select();
    $count = sql_getrecordcount();
    mysqli_data_seek($res, $recid);
    $row = mysqli_fetch_assoc($res);
    showrecnav("del", $recid, $count);
    ?>
    <br>
    <form action="endereco.php" method="post">
        <input type="hidden" name="sql" value="delete">
        <input type="hidden" name="xcodigoEndereco" value="<?php echo $row["codigoEndereco"] ?>">
    <?php showrow($row, $recid) ?>
        <p><input type="submit" name="action" value="Confirmar"></p>
    </form>
    <?php
    mysqli_free_result($res);
}
?>

<?php

function sql_select() {
    global $conn;
    global $order;
    global $ordtype;
    global $filter;
    global $filterfield;
    global $wholeonly;

    $filterstr = sqlstr($filter);
    if (!$wholeonly && isset($wholeonly) && $filterstr != '')
        $filterstr = "%" . $filterstr . "%";
    $sql = "SELECT * FROM (SELECT t1.`codigoEndereco`, t1.`codigoTipoEndereco`, lp1.`descricao` AS `lp_codigoTipoEndereco`, t1.`endereco` FROM `endereco` AS t1 LEFT OUTER JOIN `tipoendereco` AS lp1 ON (t1.`codigoTipoEndereco` = lp1.`codigoTipoEndereco`)) subq";
    if (isset($filterstr) && $filterstr != '' && isset($filterfield) && $filterfield != '') {
        $sql .= " where " . sqlstr($filterfield) . " like '" . $filterstr . "'";
    } elseif (isset($filterstr) && $filterstr != '') {
        $sql .= " where (`codigoEndereco` like '" . $filterstr . "') or (`lp_codigoTipoEndereco` like '" . $filterstr . "') or (`endereco` like '" . $filterstr . "')";
    }
    if (isset($order) && $order != '')
        $sql .= " order by `" . sqlstr($order) . "`";
    if (isset($ordtype) && $ordtype != '')
        $sql .= " " . sqlstr($ordtype);
    $res = mysqli_query($conn, $sql) or die(mysqli_error());
    return $res;
}

function sql_getrecordcount() {
    global $conn;
    global $order;
    global $ordtype;
    global $filter;
    global $filterfield;
    global $wholeonly;

    $filterstr = sqlstr($filter);
    if (!$wholeonly && isset($wholeonly) && $filterstr != '')
        $filterstr = "%" . $filterstr . "%";
    $sql = "SELECT COUNT(*) FROM (SELECT t1.`codigoEndereco`, t1.`codigoTipoEndereco`, lp1.`descricao` AS `lp_codigoTipoEndereco`, t1.`endereco` FROM `endereco` AS t1 LEFT OUTER JOIN `tipoendereco` AS lp1 ON (t1.`codigoTipoEndereco` = lp1.`codigoTipoEndereco`)) subq";
    if (isset($filterstr) && $filterstr != '' && isset($filterfield) && $filterfield != '') {
        $sql .= " where " . sqlstr($filterfield) . " like '" . $filterstr . "'";
    } elseif (isset($filterstr) && $filterstr != '') {
        $sql .= " where (`codigoEndereco` like '" . $filterstr . "') or (`lp_codigoTipoEndereco` like '" . $filterstr . "') or (`endereco` like '" . $filterstr . "')";
    }
    $res = mysqli_query($conn, $sql) or die(mysqli_error());
    $row = mysqli_fetch_assoc($res);
    reset($row);
    return current($row);
}

function sql_insert() {
    global $conn;
    global $_POST;

    $sql = "insert into `endereco` (`codigoTipoEndereco`, `endereco`) values (" . sqlvalue(@$_POST["codigoTipoEndereco"], false) . ", " . sqlvalue(@$_POST["endereco"], true) . ")";
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function sql_update() {
    global $conn;
    global $_POST;

    $sql = "update `endereco` set `codigoTipoEndereco`=" . sqlvalue(@$_POST["codigoTipoEndereco"], false) . ", `endereco`=" . sqlvalue(@$_POST["endereco"], true) . " where " . primarykeycondition();
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function sql_delete() {
    global $conn;

    $sql = "delete from `endereco` where " . primarykeycondition();
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function primarykeycondition() {
    global $_POST;
    $pk = "";
    $pk .= "(`codigoEndereco`";
    if (@$_POST["xcodigoEndereco"] == "") {
        $pk .= " IS NULL";
    } else {
        $pk .= " = " . sqlvalue(@$_POST["xcodigoEndereco"], false);
    };
    $pk .= ")";
    return $pk;
}
?>
