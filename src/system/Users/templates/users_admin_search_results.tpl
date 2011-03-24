{configgetvar name='profilemodule' assign='profilemodule'}
{gt text="Search results" assign=templatetitle}
{include file="users_admin_menu.tpl"}

<div class="z-admincontainer">
    <div class="z-adminpageicon">{icon type="view" size="large"}</div>
    <h2>{$templatetitle}</h2>

    <form id="users_searchresults" class="z-form" method="post" action="{modurl modname="Users" type="admin" func="deleteUsers"}">
        <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
        <div>
            <table class="z-datatable">
                <thead>
                    <tr>
                        {if $deleteUsers}
                        <th>&nbsp;</th>
                        {/if}
                        <th>{gt text="User name"}</th>
                        {if $profilemodule}
                        <th>{gt text="Internal name"}</th>
                        {/if}
                        <th>{gt text="E-mail address"}</th>
                        <th class="z-right">{gt text="Actions"}</th>
                    </tr>
                </thead>
                <tbody>
                    {section name=item loop=$items}
                    <tr class="{cycle values='z-odd,z-even'}">
                        {if $deleteUsers}
                        <td>{if ($items[item].uid != 1) && ($items[item].uid != 2)}<input type="checkbox" name="userid[]" value="{$items[item].uid}" />{/if}</td>
                        {/if}
                        <td>{$items[item].uname}</td>
                        {if $profilemodule}
                        <td>{usergetvar name='realname' uid=$items[item].uid}</td>
                        {/if}
                        <td>
                            {if !empty($items[item].email) && ($items[item].uid != 1)}
                            {$items[item].email}
                            {/if}
                        </td>
                        <td class="z-right">
                            {if $actions[item].modifyUrl}<a href="{$actions[item].modifyUrl|safehtml}">{img modname=core set=icons/extrasmall src=xedit.png __alt="Edit" __title="Edit" class="tooltips"}</a>{/if}
                            {if $actions[item].deleteUrl}<a href="{$actions[item].deleteUrl|safehtml}">{img modname=core set=icons/extrasmall src=14_layer_deletelayer.png __alt="Delete" __title="Delete" class="tooltips"}</a>{/if}
                        </td>
                    </tr>
                    {/section}
                </tbody>
            </table>

            {if $deleteUsers}
            <p>
                <a href="#" id="select_all">{gt text="Select all"}</a> / <a href="#" id="deselect_all">{gt text="De-select all"}</a>
            </p>
            {/if}

            <div class="z-formbuttons z-buttons">
                {button type='submit' src='14_layer_deletelayer.png' set='icons/extrasmall' __alt="Delete selected users" __title="Delete selected users" __text="Delete selected users"}
                <a href="{modurl modname='Users' type='admin' func='main'}" title="{gt text='Return to User Administration'}">{img modname='core' src='button_cancel.png' set='icons/extrasmall'  __alt="Return to User Administration" __title="Return to User Administration"} {gt text='Return to User Administration'}</a>
            </div>
        </div>
    </form>
</div>
{if $deleteUsers}
<script type="text/javascript">
    $('select_all').observe('click', function(e){
        Zikula.toggleInput('users_searchresults', true);
        e.stop()
    });
    $('deselect_all').observe('click', function(e){
        Zikula.toggleInput('users_searchresults', false);
        e.stop()
    });
</script>
{/if}
<script type="text/javascript">
    Zikula.UI.Tooltips($$('.tooltips'));
</script>