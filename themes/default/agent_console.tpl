{* vim: set expandtab tabstop=4 softtabstop=4 shiftwidth=4:
  Codificación: UTF-8
  +----------------------------------------------------------------------+
  | Agent_console modificado por Renato Siqueira                         |
  | http://www.github.com/renatosiqueira                                 |
  +----------------------------------------------------------------------+
  | Copyright (c) 2006 Palosanto Solutions S. A.                         |
  +----------------------------------------------------------------------+
  | The contents of this file are subject to the General Public License  |
  | (GPL) Version 2 (the "License"); you may not use this file except in |
  | compliance with the License. You may obtain a copy of the License at |
  | http://www.opensource.org/licenses/gpl-license.php                   |
  |                                                                      |
  | Software distributed under the License is distributed on an "AS IS"  |
  | basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See  |
  | the License for the specific language governing rights and           |
  | limitations under the License.                                       |
  +----------------------------------------------------------------------+
  | The Initial Developer of the Original Code is PaloSanto Solutions    |
  +----------------------------------------------------------------------+
*}

{* Incluir todas as Bibliotecas e CSS do módulo *}
{foreach from=$LISTA_JQUERY_CSS item=CURR_ITEM}
    {if $CURR_ITEM[0] == 'css'}
        <link rel="stylesheet" href='{$CURR_ITEM[1]}' />
    {/if}
    {if $CURR_ITEM[0] == 'js'}
        <script type="text/javascript" src='{$CURR_ITEM[1]}'></script>
    {/if}
{/foreach}

{* DIV: OK MSGS *}
<div id="issabel-callcenter-info-message" class="notice notice-success">
    <strong>Info:</strong>
    <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
    <span id="issabel-callcenter-info-message-text"></span>
</div>

{* DIV: FAIL MSGS *}
<div id="issabel-callcenter-error-message" class="notice notice-danger">
    <strong>Aviso:</strong>
    <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
    <span id="issabel-callcenter-error-message-text"></span>
</div>

{* DIV: SCRIPT *}
<div class="divScript" id="script">
    <legend><a class="closeDivScript" href="#" onclick="document.getElementById('script').style.display='none';"><i class="fa fa-times"></i></a> <b>{$TAB_LLAMADA_SCRIPT}</b></legend>
    <div class="divScriptText" id="issabel-callcenter-llamada-script">{$CONTENIDO_LLAMADA_SCRIPT}</div>
</div>

{* SECTION: STATUS OPERATOR *}
<section class="notice agentStatus">
    <div class="row">
        <div class="col-xs-12 col-sm-6 col-md-8 agentStatusPosition">
            {* NAME / STATUS / TIMER *}
            <span class="agentStatusName">{$title}</span><br/>
            <span>
                <strong>Status:</strong> <span id="issabel-callcenter-estado-agente-texto">{$TEXTO_ESTADO_AGENTE_INICIAL}</span> (<span id="issabel-callcenter-cronometro">{$CRONOMETRO}</span>)
            </span>
        </div>
        <div class="col-xs-6 col-md-4 logoutOption">
            {* TRANSFER *}
            <button id="btn_transfer" type="button" class="btn btn-primary issabel-callcenter-boton-activo" >
                {$BTN_TRANSFER}
            </button>
            {* SCRIPT *}
            <button type="button" class="btn btn-primary" onclick="toggleScript();">
                {$TAB_LLAMADA_SCRIPT}
            </button>
            {* LOGOUT *}
            <button class="btn btnLogout" id="btn_logout" type="button">
                {$BTN_FINALIZAR_LOGIN}
            </button>
        </div>
    </div>
</section>

{* SECTION: MAIN *}
<section class="mainPosition">
    <div class="nav-tabs-custom">
        <ul class="nav nav-tabs" id="issabel-callcenterContent">
            <li class="active"><a href="#information" data-toggle="tab">{$TAB_LLAMADA}</a></li>
            <li><a href="#forms" data-toggle="tab">{$TAB_LLAMADA_FORM}</a></li>
            {foreach from=$CUSTOM_PANELS item=HTML_PANEL}
                <li><a href="#tabs-{$HTML_PANEL.panelname}" data-toggle="tab">{$HTML_PANEL.title}</a></li>
            {/foreach}
                <li class="pull-right">
                    <button id="btn_hangup" type="button" class="btn btn-primary issabel-callcenter-boton-activo">{$BTN_COLGAR_LLAMADA}</button>
                </li>
                <li class="pull-right">
                    <button id="btn_togglebreak" type="button" class="btn btn-primary {$CLASS_BOTON_BREAK}" >{$BTN_BREAK}</button>
                </li>
                <li class="pull-right"><button id="btn_agendar_llamada" type="button" class="btn btn-primary" {if $CALLINFO_CALLTYPE != 'outgoing'}disabled="disabled"{/if}>{$BTN_AGENDAR_LLAMADA}</button></li>
                {if $BTN_VTIGERCRM}
                    <li class="pull-right"><button id="btn_vtigercrm">{$BTN_VTIGERCRM}</button></li>
                {/if}
        </ul>
    </div>
    <div class="tab-content" id="tab-content">
        {* DIV INFORMATIONS *}
        <div class="tab-pane active" id="information">
            <legend><b>{$TAB_LLAMADA_INFO}</b></legend>
            <div id="issabel-callcenter-llamada-info">{$CONTENIDO_LLAMADA_INFORMACION}</div>
        </div>

        {* DIV FORMS *}
        <div class="tab-pane" id="forms">
            <div id="issabel-callcenter-llamada-form">{$CONTENIDO_LLAMADA_FORMULARIO}</div>
            <div class="box-footer">
                <button id="btn_guardar_formularios" type="button" class="btn btn-primary pull-center positionButtonForm">{$BTN_GUARDAR_FORMULARIOS}</button></li>
            </div>
        </div>

        {foreach from=$CUSTOM_PANELS item=HTML_PANEL}
        <div class="tab-pane" id="tabs-{$HTML_PANEL.panelname}">
            {$HTML_PANEL.content}
        </div>
        {/foreach}
    </div>    
    <!-- nav-tabs-custom -->
</section>

<div id="issabel-callcenter-seleccion-break" title="{$TITLE_BREAK_DIALOG}">
    <form>
        <select name="break_select" id="break_select" style="width: 100%">
            {html_options options=$LISTA_BREAKS}
        </select>
    </form>
</div>
{* issabel-callcenter-seleccion-break *}

<div id="issabel-callcenter-seleccion-transfer" title="{$TITLE_TRANSFER_DIALOG}">
    <form>
        <table border="0" cellpadding="0" style="width: 100%;">
            <tr>
                <td><input
                name="transfer_extension"
                id="transfer_extension"
                class="ui-widget-content ui-corner-all"
                style="width: 100%" /></td>
            </tr>
            <tr>
                <td>
                    <div align="center" id="transfer_type_radio">
                        <input type="radio" id="transfer_type_blind" name="transfer_type" value="blind" checked="checked"/><label for="transfer_type_blind">{$LBL_TRANSFER_BLIND}</label>
                        <input type="radio" id="transfer_type_attended" name="transfer_type" value="attended" /><label for="transfer_type_attended">{$LBL_TRANSFER_ATTENDED}</label>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
{* issabel-callcenter-seleccion-transfer *}

<div id="issabel-callcenter-agendar-llamada" title="{$TITLE_SCHEDULE_CALL}">
	<div
	    id="issabel-callcenter-agendar-llamada-error-message"
	    class="ui-state-error ui-corner-all">
	    <p>
	        <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
	        <span id="issabel-callcenter-agendar-llamada-error-message-text"></span>
	    </p>
	</div>
    <form>
        <table border="0" cellpadding="0" style="width: 100%;">
            <tr>
                <td><label style="display: table-cell;" for="schedule_new_phone"><b>{$LBL_CONTACTO_TELEFONO}:&nbsp;</b></label></td>
                <td><input
                    name="schedule_new_phone"
                    id="schedule_new_phone"
                    class="ui-widget-content ui-corner-all"
                    maxlength="64"
                    style="display: table-cell; width: 100%;"
                    value="{$TEXTO_CONTACTO_TELEFONO|escape:"html"}" /></td>
            </tr>
            <tr>
                <td><label style="display: table-cell;" for="schedule_new_name"><b>{$LBL_CONTACTO_NOMBRES}:&nbsp;</b></label></td>
                <td><input
                    name="schedule_new_name"
                    id="schedule_new_name"
                    class="ui-widget-content ui-corner-all"
                    maxlength="250"
                    style="display: table-cell; width: 100%;"
                    value="{$TEXTO_CONTACTO_NOMBRES|escape:"html"}" /></td>
            </tr>
        </table>
        <hr />
        <div align="center" id="schedule_radio" style="width: 100%">
            <input type="radio" id="schedule_type_campaign_end" name="schedule_type" value="campaign_end" checked="checked"/><label for="schedule_type_campaign_end">{$LBL_SCHEDULE_CAMPAIGN_END}</label>
            <input type="radio" id="schedule_type_bydate" name="schedule_type" value="bydate" /><label for="schedule_type_bydate">{$LBL_SCHEDULE_BYDATE}</label>
        </div>
        <br/>
        <table id="schedule_date" border="0" cellpadding="0" style="width: 100%;">
            <tr>
                <td><label for="schedule_date_start"><b>{$LBL_SCHEDULE_DATE_START}:&nbsp;</b></label></td>
                <td><input type="text" class="ui-widget-content ui-corner-all" name="schedule_date_start" id="schedule_date_start" /></td>
                <td><label for="schedule_date_end"><b>{$LBL_SCHEDULE_DATE_END}:&nbsp;</b></label></td>
                <td><input type="text" class="ui-widget-content ui-corner-all" name="schedule_date_end" id="schedule_date_end" /></td>
            </tr>
            <tr>
                <td><label><b>{$LBL_SCHEDULE_TIME_START}:&nbsp;</b></label></td>
                <td><select
                        name="schedule_time_start_hh"
                        id="schedule_time_start_hh"
                        class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">{html_options options=$SCHEDULE_TIME_HH}
                    </select>:<select
                        name="schedule_time_start_mm"
                        id="schedule_time_start_mm"
                        class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">{html_options options=$SCHEDULE_TIME_MM}
                    </select></td>
                <td><label><b>{$LBL_SCHEDULE_TIME_END}:&nbsp;</b></label></td>
                <td><select
                        name="schedule_time_end_hh"
                        id="schedule_time_end_hh"
                        class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">{html_options options=$SCHEDULE_TIME_HH}
                    </select>:<select
                        name="schedule_time_end_mm"
                        id="schedule_time_end_mm"
                        class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">{html_options options=$SCHEDULE_TIME_MM}
                    </select></td>
            </tr>
            <tr>
                <td colspan="4"><input type="checkbox" id="schedule_same_agent" name="schedule_same_agent" /><label for="schedule_same_agent">{$LBL_SCHEDULE_SAME_AGENT}</label></td>
            </tr>
        </table>
    </form>
</div>

{literal}
<script type="text/javascript">
// Aplicar temas de jQueryUI a diversos elementos
$(document).ready(function() {
{/literal}
    apply_ui_styles({$APPLY_UI_STYLES});
    initialize_client_state({$INITIAL_CLIENT_STATE});
{literal}
});

function toggleScript(){
    var item = document.getElementById("script");
    item.style.display = item.style.display === 'block' ? 'none' : 'block';
};

// Init
document.getElementById('script').style.display='none';
</script>
{/literal}
