<ul class="latest-list">
    {foreach $aComments as $oComment}
        {assign var="oUser" value=$oComment->getUser()}
        {assign var="oTopic" value=$oComment->getTarget()}
        {if $oTopic}
            {assign var="oBlog" value=$oTopic->getBlog()}
            <li class="js-title-comment"
                title="{$oComment->getText()|strip_tags|trim|truncate:100:'...'|escape:'html'}">
                <p>
                    <a href="{$oUser->getProfileUrl()}" class="author">{$oUser->getDisplayName()}</a>
                    <time datetime="{date_format date=$oComment->getDate() format='c'}"
                          title="{date_format date=$oComment->getDate() format="j F Y, H:i"}">
                        {date_format date=$oComment->getDate() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}
                    </time>
                </p>
                <a href="{if Config::Get('module.comment.nested_per_page')}{router page='comments'}{else}{$oTopic->getUrl()}#comment{/if}{$oComment->getId()}"
                   class="stream-topic">{$oTopic->getTitle()|escape:'html'}</a>
                <span class="block-item-comments"><i class="icon-synio-comments-small"></i>{$oTopic->getCountComment()}</span>
            </li>
        {/if}
    {/foreach}
</ul>


<footer>
    <a href="{router page='rss'}allcomments/">RSS</a>
</footer>