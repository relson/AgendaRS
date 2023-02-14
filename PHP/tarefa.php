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
        <title>AgendaRS - [Tarefa]</title>
        <meta name="generator" http-equiv="content-type" content="text/html"charset="ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <table class="bd" width="100%"><tr><td class="hr"><h2>AgendaRS - [Tarefa]</h2></td></tr></table>
        <table width="100%">
            <tr>

                <td width="10%" valign="top">
                    <h3>Cadastro</h3>
            <li><a href="contato.php?a=reset">Contato</a>
            <li><a href="telefone.php?a=reset">Telefone</a>
            <li><a href="email.php?a=reset">e-mail</a>
            <li><a href="endereco.php?a=reset">Endere&ccedil;o</a>
            <li>Tarefa
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
        <tr><td>Cadastro: tarefa</td></tr>
        <tr><td>Exibindo registros <?php echo $startrec + 1 ?> - <?php echo $reccount ?> of <?php echo $count ?></td></tr>
    </table>
    <hr size="1" noshade>
    <form action="tarefa.php" method="post">
        <table class="bd" border="0" cellspacing="1" cellpadding="4">
            <tr>
                <td><b>Filtros</b>&nbsp;</td>
                <td><input type="text" name="filter" value="<?php echo $filter ?>"></td>
                <td><select name="filter_field">
                        <option value="">Todos os Campos</option>
                        <option value="<?php echo "codigoTarefa" ?>"<?php
    if ($filterfield == "codigoTarefa") {
        echo "selected";
    }
    ?>><?php echo htmlspecialchars("Código") ?></option>
                        <option value="<?php echo "lp_codigoTarefaStatus" ?>"<?php
                            if ($filterfield == "lp_codigoTarefaStatus") {
                                echo "selected";
                            }
    ?>><?php echo htmlspecialchars("Status") ?></option>
                        <option value="<?php echo "dataInicio" ?>"<?php
                    if ($filterfield == "dataInicio") {
                        echo "selected";
                    }
    ?>><?php echo htmlspecialchars("Data de Inicio") ?></option>
                        <option value="<?php echo "horaInicial" ?>"<?php
                            if ($filterfield == "horaInicial") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Hora de Inicio") ?></option>
                        <option value="<?php echo "dataLimite" ?>"<?php
                            if ($filterfield == "dataLimite") {
                                echo "selected";
                            }
    ?>><?php echo htmlspecialchars("Data Limite") ?></option>
                        <option value="<?php echo "horaLimite" ?>"<?php
                    if ($filterfield == "horaLimite") {
                        echo "selected";
                    }
    ?>><?php echo htmlspecialchars("Hora Limite") ?></option>
                        <option value="<?php echo "titulo" ?>"<?php
                            if ($filterfield == "titulo") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Titulo") ?></option>
                        <option value="<?php echo "descricao" ?>"<?php
                            if ($filterfield == "descricao") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Descricao") ?></option>
                        <option value="<?php echo "lp_codigoTarefaPrioridade" ?>"<?php
                            if ($filterfield == "lp_codigoTarefaPrioridade") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Prioridade") ?></option>
                        <option value="<?php echo "datahoracriacao" ?>"<?php
                            if ($filterfield == "datahoracriacao") {
                                echo "selected";
                            }
                            ?>><?php echo htmlspecialchars("Criado em") ?></option>
                    </select></td>
                <td><input type="checkbox" name="wholeonly"<?php echo $checkstr ?>>Coincidir palavras completas</td>
                </td></tr>
            <tr>
                <td>&nbsp;</td>
                <td><input type="submit" name="action" value="Filtrar"></td>
                <td><a href="tarefa.php?a=reset">Limpar Filtro</a></td>
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
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "codigoTarefa" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Codigo") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "lp_codigoTarefaStatus" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Status") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "dataInicio" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Data de Inicio") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "horaInicial" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Hora de Inicio") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "dataLimite" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Data Limite") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "horaLimite" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Hora Limite") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "titulo" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Titulo") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "descricao" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Descricao") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "lp_codigoTarefaPrioridade" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Prioridade") ?></a></td>
            <td class="hr"><a class="hr" href="tarefa.php?order=<?php echo "datahoracriacao" ?>&type=<?php echo $ordtypestr ?>"><?php echo htmlspecialchars("Criado em") ?></a></td>
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
                <td class="<?php echo $style ?>"><a href="tarefa.php?a=view&recid=<?php echo $i ?>">Ver</a></td>
                <td class="<?php echo $style ?>"><a href="tarefa.php?a=edit&recid=<?php echo $i ?>">Editar</a></td>
                <td class="<?php echo $style ?>"><a href="tarefa.php?a=del&recid=<?php echo $i ?>">Excluir</a></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["codigoTarefa"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["lp_codigoTarefaStatus"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["dataInicio"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["horaInicial"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["dataLimite"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["horaLimite"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["titulo"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["descricao"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["lp_codigoTarefaPrioridade"]) ?></td>
                <td class="<?php echo $style ?>"><?php echo htmlspecialchars($row["datahoracriacao"]) ?></td>
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
            <td class="dr"><?php echo htmlspecialchars($row["codigoTarefa"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Status") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["lp_codigoTarefaStatus"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Data de Inicio") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["dataInicio"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Hora de Inicio") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["horaInicial"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Data Limite") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["dataLimite"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Hora Limite") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["horaLimite"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Titulo") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["titulo"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Descricao") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["descricao"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Prioridade") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["lp_codigoTarefaPrioridade"]) ?></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Criado em") . "&nbsp;" ?></td>
            <td class="dr"><?php echo htmlspecialchars($row["datahoracriacao"]) ?></td>
        </tr>
    </table>
                <?php } ?>

                <?php

                function showroweditor($row, $iseditmode) {
                    global $conn;
                    ?>
    <table class="tbl" border="0" cellspacing="1" cellpadding="5"width="50%">
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Status") . "&nbsp;" ?></td>
            <td class="dr"><select name="codigoTarefaStatus">
    <?php
    $sql = "select `codigoTarefaStatus`, `descricao` from `tarefastatus`";
    $res = mysqli_query($conn, $sql) or die(mysqli_error());

    while ($lp_row = mysqli_fetch_assoc($res)) {
        $val = $lp_row["codigoTarefaStatus"];
        $caption = $lp_row["descricao"];
        if ($row["codigoTarefaStatus"] == $val) {
            $selstr = " selected";
        } else {
            $selstr = "";
        }
        ?><option value="<?php echo $val ?>"<?php echo $selstr ?>><?php echo $caption ?></option>
    <?php } ?></select>
            </td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Data de Início") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="dataInicio" value="<?php echo str_replace('"', '&quot;', trim($row["dataInicio"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Hora de Início") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="horaInicial" value="<?php echo str_replace('"', '&quot;', trim($row["horaInicial"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Data Limite") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="dataLimite" value="<?php echo str_replace('"', '&quot;', trim($row["dataLimite"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Hora Limite") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="horaLimite" value="<?php echo str_replace('"', '&quot;', trim($row["horaLimite"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Título") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="titulo" value="<?php echo str_replace('"', '&quot;', trim($row["titulo"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Descrição") . "&nbsp;" ?></td>
            <td class="dr"><input type="text" name="descricao" maxlength="50" value="<?php echo str_replace('"', '&quot;', trim($row["descricao"])) ?>"></td>
        </tr>
        <tr>
            <td class="hr"><?php echo htmlspecialchars("Prioridade") . "&nbsp;" ?></td>
            <td class="dr"><select name="codigoTarefaPrioridade">
    <?php
    $sql = "select `codigoTarefaPrioridade`, `descricao` from `tarefaprioridade`";
    $res = mysqli_query($conn, $sql) or die(mysqli_error());

    while ($lp_row = mysqli_fetch_assoc($res)) {
        $val = $lp_row["codigoTarefaPrioridade"];
        $caption = $lp_row["descricao"];
        if ($row["codigoTarefaPrioridade"] == $val) {
            $selstr = " selected";
        } else {
            $selstr = "";
        }
        ?><option value="<?php echo $val ?>"<?php echo $selstr ?>><?php echo $caption ?></option>
            <?php } ?></select>
            </td>
        </tr>
    </table>
        <?php } ?>

        <?php

        function showpagenav($page, $pagecount) {
            ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="tarefa.php?a=add">Inserir Registro</a>&nbsp;</td>
            <?php if ($page > 1) { ?>
                <td><a href="tarefa.php?page=<?php echo $page - 1 ?>">&lt;&lt;&nbsp;Anterior</a>&nbsp;</td>
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
                                <td><a href="tarefa.php?page=<?php echo $j ?>"><?php echo $j ?></a></td>
                            <?php
                            }
                        }
                    } else {
                        ?>
                        <td><a href="tarefa.php?page=<?php echo $startpage ?>"><?php echo $startpage . "..." . $count ?></a></td>
            <?php
            }
        }
    }
    ?>
    <?php if ($page < $pagecount) { ?>
                <td>&nbsp;<a href="tarefa.php?page=<?php echo $page + 1 ?>">Próximo&nbsp;&gt;&gt;</a>&nbsp;</td>
    <?php } ?>
        </tr>
    </table>
<?php } ?>

<?php

function showrecnav($a, $recid, $count) {
    ?>
    <table class="bd" border="0" cellspacing="1" cellpadding="4">
        <tr>
            <td><a href="tarefa.php">Pagina Inicial</a></td>
        <?php if ($recid > 0) { ?>
                <td><a href="tarefa.php?a=<?php echo $a ?>&recid=<?php echo $recid - 1 ?>">Registro Anterior</a></td>
        <?php } if ($recid < $count - 1) { ?>
                <td><a href="tarefa.php?a=<?php echo $a ?>&recid=<?php echo $recid + 1 ?>">Próximo Registro</a></td>
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
            <td><a href="tarefa.php">Pagina Inicial</a></td>
        </tr>
    </table>
    <hr size="1" noshade>
    <form enctype="multipart/form-data" action="tarefa.php" method="post">
        <p><input type="hidden" name="sql" value="insert"></p>
    <?php
    $row = array(
        "codigoTarefa" => "",
        "codigoTarefaStatus" => "",
        "dataInicio" => "",
        "horaInicial" => "",
        "dataLimite" => "",
        "horaLimite" => "",
        "titulo" => "",
        "descricao" => "",
        "codigoTarefaPrioridade" => "",
        "datahoracriacao" => "");
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
            <td><a href="tarefa.php?a=add">Inserir Registro</a></td>
            <td><a href="tarefa.php?a=edit&recid=<?php echo $recid ?>">Editar Registro</a></td>
            <td><a href="tarefa.php?a=del&recid=<?php echo $recid ?>">Excluir Registro</a></td>
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
    <form enctype="multipart/form-data" action="tarefa.php" method="post">
        <input type="hidden" name="sql" value="update">
        <input type="hidden" name="xcodigoTarefa" value="<?php echo $row["codigoTarefa"] ?>">
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
    <form action="tarefa.php" method="post">
        <input type="hidden" name="sql" value="delete">
        <input type="hidden" name="xcodigoTarefa" value="<?php echo $row["codigoTarefa"] ?>">
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
    $sql = "SELECT * FROM (SELECT t1.`codigoTarefa`, t1.`codigoTarefaStatus`, lp1.`descricao` AS `lp_codigoTarefaStatus`, t1.`dataInicio`, t1.`horaInicial`, t1.`dataLimite`, t1.`horaLimite`, t1.`titulo`, t1.`descricao`, t1.`codigoTarefaPrioridade`, lp8.`descricao` AS `lp_codigoTarefaPrioridade`, t1.`datahoracriacao` FROM `tarefa` AS t1 LEFT OUTER JOIN `tarefastatus` AS lp1 ON (t1.`codigoTarefaStatus` = lp1.`codigoTarefaStatus`) LEFT OUTER JOIN `tarefaprioridade` AS lp8 ON (t1.`codigoTarefaPrioridade` = lp8.`codigoTarefaPrioridade`)) subq";
    if (isset($filterstr) && $filterstr != '' && isset($filterfield) && $filterfield != '') {
        $sql .= " where " . sqlstr($filterfield) . " like '" . $filterstr . "'";
    } elseif (isset($filterstr) && $filterstr != '') {
        $sql .= " where (`codigoTarefa` like '" . $filterstr . "') or (`lp_codigoTarefaStatus` like '" . $filterstr . "') or (`dataInicio` like '" . $filterstr . "') or (`horaInicial` like '" . $filterstr . "') or (`dataLimite` like '" . $filterstr . "') or (`horaLimite` like '" . $filterstr . "') or (`titulo` like '" . $filterstr . "') or (`descricao` like '" . $filterstr . "') or (`lp_codigoTarefaPrioridade` like '" . $filterstr . "') or (`datahoracriacao` like '" . $filterstr . "')";
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
    $sql = "SELECT COUNT(*) FROM (SELECT t1.`codigoTarefa`, t1.`codigoTarefaStatus`, lp1.`descricao` AS `lp_codigoTarefaStatus`, t1.`dataInicio`, t1.`horaInicial`, t1.`dataLimite`, t1.`horaLimite`, t1.`titulo`, t1.`descricao`, t1.`codigoTarefaPrioridade`, lp8.`descricao` AS `lp_codigoTarefaPrioridade`, t1.`datahoracriacao` FROM `tarefa` AS t1 LEFT OUTER JOIN `tarefastatus` AS lp1 ON (t1.`codigoTarefaStatus` = lp1.`codigoTarefaStatus`) LEFT OUTER JOIN `tarefaprioridade` AS lp8 ON (t1.`codigoTarefaPrioridade` = lp8.`codigoTarefaPrioridade`)) subq";
    if (isset($filterstr) && $filterstr != '' && isset($filterfield) && $filterfield != '') {
        $sql .= " where " . sqlstr($filterfield) . " like '" . $filterstr . "'";
    } elseif (isset($filterstr) && $filterstr != '') {
        $sql .= " where (`codigoTarefa` like '" . $filterstr . "') or (`lp_codigoTarefaStatus` like '" . $filterstr . "') or (`dataInicio` like '" . $filterstr . "') or (`horaInicial` like '" . $filterstr . "') or (`dataLimite` like '" . $filterstr . "') or (`horaLimite` like '" . $filterstr . "') or (`titulo` like '" . $filterstr . "') or (`descricao` like '" . $filterstr . "') or (`lp_codigoTarefaPrioridade` like '" . $filterstr . "') or (`datahoracriacao` like '" . $filterstr . "')";
    }
    $res = mysqli_query($conn, $sql) or die(mysqli_error());
    $row = mysqli_fetch_assoc($res);
    reset($row);
    return current($row);
}

function sql_insert() {
    global $conn;
    global $_POST;

    $sql = "insert into `tarefa` (`codigoTarefaStatus`, `dataInicio`, `horaInicial`, `dataLimite`, `horaLimite`, `titulo`, `descricao`, `codigoTarefaPrioridade`) values (" . sqlvalue(@$_POST["codigoTarefaStatus"], false) . ", " . sqlvalue(@$_POST["dataInicio"], true) . ", " . sqlvalue(@$_POST["horaInicial"], true) . ", " . sqlvalue(@$_POST["dataLimite"], true) . ", " . sqlvalue(@$_POST["horaLimite"], true) . ", " . sqlvalue(@$_POST["titulo"], true) . ", " . sqlvalue(@$_POST["descricao"], true) . ", " . sqlvalue(@$_POST["codigoTarefaPrioridade"], false) . ")";
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function sql_update() {
    global $conn;
    global $_POST;

    $sql = "update `tarefa` set `codigoTarefaStatus`=" . sqlvalue(@$_POST["codigoTarefaStatus"], false) . ", `dataInicio`=" . sqlvalue(@$_POST["dataInicio"], true) . ", `horaInicial`=" . sqlvalue(@$_POST["horaInicial"], true) . ", `dataLimite`=" . sqlvalue(@$_POST["dataLimite"], true) . ", `horaLimite`=" . sqlvalue(@$_POST["horaLimite"], true) . ", `titulo`=" . sqlvalue(@$_POST["titulo"], true) . ", `descricao`=" . sqlvalue(@$_POST["descricao"], true) . ", `codigoTarefaPrioridade`=" . sqlvalue(@$_POST["codigoTarefaPrioridade"], false) . " where " . primarykeycondition();
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function sql_delete() {
    global $conn;

    $sql = "delete from `tarefa` where " . primarykeycondition();
    mysqli_query($conn, $sql) or die(mysqli_error());
}

function primarykeycondition() {
    global $_POST;
    $pk = "";
    $pk .= "(`codigoTarefa`";
    if (@$_POST["xcodigoTarefa"] == "") {
        $pk .= " IS NULL";
    } else {
        $pk .= " = " . sqlvalue(@$_POST["xcodigoTarefa"], false);
    };
    $pk .= ")";
    return $pk;
}
?>
