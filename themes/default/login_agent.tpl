{* vim: set expandtab tabstop=4 softtabstop=4 shiftwidth=4:
  Codificación: UTF-8
  +----------------------------------------------------------------------+
  | Agent_console modificado por Renato Siqueira                         |
  | http://www.github.com/renatosiqueira                                 |
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

<div class="text-center lockscreen-wrapper">
	<div class="logo" align="center">{$WELCOME_AGENT}</div>
	<!-- Main Form -->
	<div class="login-form-1">

  {if $NO_EXTENSIONS}
    <p><h4 align="center">{$LABEL_NOEXTENSIONS}</h4></p>
  {elseif $NO_AGENTS}
    <p><h4 align="center">{$LABEL_NOAGENTS}</h4></p>
  {else}

    <!-- DIV DE ALERTAS -->
    <div id="login_fila_estado" {$ESTILO_FILA_ESTADO_LOGIN}>
      <!-- Loading -->
      <div align="center" id="login_icono_espera" height='1' class="callout callout-info">
        <img id="reloj" src="modules/{$MODULE_NAME}/images/loading.gif" border="0" alt="">
        <!-- MSG DE ESPERA -->
        <div align="center" style="font-weight: bold;" id="login_msg_espera">
          {$MSG_ESPERA}
        </div>
      </div>

      <!-- MSG DE ERRO -->
      <div id="div_erro" class="callout callout-danger" >
        <h4>Atenção!</h4>
        <p id="login_msg_error"></p>
      </div>
    </div>

    <!-- DIV DE LOGIN -->
    <form id="login-form" class="text-left" method="POST"  action="index.php?menu={$MODULE_NAME}" onsubmit="event.preventDefault(); do_login();">
      <div class="main-login-form">
        <div class="login-group">
          <div class="form-group">
            {* AGENTE *}
              <select class="form-control" id="input_agent_user" name="input_agent_user">
                  {html_options options=$LISTA_AGENTES selected=$ID_AGENT}
              </select>
            {* CALLBACK *}
              <label class="control-label" id="label_extension_callback">{$CALLBACK_EXTENSION}:</label>
              <div>
                <select class="form-control" id="input_extension_callback" name="input_extension_callback">
                    {html_options options=$LISTA_EXTENSIONES_CALLBACK selected=$ID_EXTENSION_CALLBACK}
                </select>
              </div>
          </div>

          <div class="form-group">
            <div class="form-group">
            {* AGENTE *}
              <select class="form-control" align="center" name="input_extension" id="input_extension">
                {html_options options=$LISTA_EXTENSIONES selected=$ID_EXTENSION}
              </select>
            
            {* CALLBACK *}
              <label class="control-label positionLabel" id="label_password_callback">{$PASSWORD}:</label>
              <div class="form-control" id="input_password_callback">
                <input class="form-control" type="password" name="input_password_callback" placeholder="{$PASSWORD}">
              </div>
              <div class="form-control">
                <input type="checkbox" name="input_callback" id="input_callback">
                <label for="input_callback">{$CALLBACK_LOGIN}</label>
              </div>
            </div>
          </div>
        </div>
        <button type="submit" id="submit_agent_login" name="submit_agent_login" value="{$LABEL_SUBMIT}" class="login-button"><i class="fa fa-chevron-right"></i></button>
      </div>
    </form>

  {/if}

	</div>
	<!-- end:Main Form -->
</div>

{if $REANUDAR_VERIFICACION}
<script type="text/javascript">
  do_checklogin();
</script>
{/if}