 {* Тема оформления Experience v.1.0  для Alto CMS      *}
 {* @licence     CC Attribution-ShareAlike   *}

{$oUser=$oComment->getUser()}
{$oVote=$oComment->getVote()}

{if $sDateReadLast==''}
    {$sTargetType = $oComment->getTargetType()}
    {if $sTargetType == 'topic'}
        {assign var="sDateReadLast" value="{$oComment->getTarget()->getDateRead()}"}
    {/if}
{/if}

{$sCommentClass = ""}
{if $oComment->isBad()}
    {$sCommentClass = "$sCommentClass comment-bad"}
{/if}
{if $oComment->getDelete()}
    {$sCommentClass = "$sCommentClass comment-deleted"}
{elseif E::UserId()==$oComment->getUserId()}
    {$sCommentClass = "$sCommentClass comment-self"}
{elseif $sDateReadLast <= $oComment->getDate()}
    {$sCommentClass = "$sCommentClass comment-new"}
{/if}
<div id="comment_id_{$oComment->getId()}"  data-level="{$oComment->getLevel() + 1}"  class="comment comment-level comment-level-{$oComment->getLevel() + 1} {$sCommentClass}">
    <div class="panel panel-default comment">
        <div class="panel-body">
        {if !$oComment->getDelete() OR $bOneComment OR E::IsAdmin() OR $oComment->isDeletable()}
            <a name="comment{$oComment->getId()}"></a>
            {if !$bCommentList}
            <div class="collapse-block" style="display: none;">
                <a href="#" onclick="return false"><i class="fa fa-minus-square-o"></i></a>
            </div>
            {/if}
            <div class="comment-content">
                <div class="comment-tools">
                    <ul>
                        <li class="comment-user">
                            <a href="{$oUser->getProfileUrl()}" class="mal0 js-popup-user-{$oUser->getId()}">
                                <img src="{$oUser->getAvatarUrl('small')}" alt="{$oUser->getDisplayName()}"/>
                            </a>
                            <a class="userlogo link link-blue link-lead link-clear {if $iAuthorId == $oUser->getId()}comment-topic-author{/if}"
                               {if $iAuthorId == $oUser->getId()}title="{$sAuthorNotice}"{/if}
                               href="{$oUser->getProfileUrl()}">
                                {$oUser->getDisplayName()}
                            </a>
                        </li>
                        <li class="comment-date-block">
                            <a class="link link-blue link-lead link-clear" href="#">
                                <span class="topic-date">{$oComment->getDate()|date_format:'d.m.Y'}</span>
                                <span class="topic-time">{$oComment->getDate()|date_format:'H:i'}</span>
                            </a>
                        </li>
                        {if !$bCommentList}
                            {if $oComment->getPid()}
                            <li class="comment-up comment-goto-parent">
                                <a class="link link-light-gray link-lead link-clear"
                                   onclick="ls.comments.goToParentComment({$oComment->getId()},{$oComment->getPid()}); return false;"
                                   title="{$aLang.comment_goto_parent}"
                                   href="#">
                                    <i class="fa fa-long-arrow-up"></i>
                                </a>
                            </li>
                            {/if}
                            <li class="comment-down comment-goto-child"  style="display: none;">
                                <a class="link link-light-gray link-lead link-clear"
                                   {*onclick="ls.comment.goToNextComment(); return false;"*}
                                   title="{$aLang.comment_goto_child}"
                                   href="#">
                                    <i class="fa fa-long-arrow-down"></i>
                                </a>
                            </li>
                        {/if}
                        <li class="comment-anchor">
                            <a class="link link-light-gray link-lead link-clear"
                               href="{if Config::Get('module.comment.nested_per_page')}{router page='comments'}{else}#comment{/if}{$oComment->getId()}">
                                <i class="fa fa-anchor"></i>
                            </a>
                        </li>
                        {if E::IsUser() AND !$bNoCommentFavourites}
                            <li class="comment-favourite">
                                <a class="link link-light-gray link-lead link-clear {if $oComment->getIsFavourite()}active{/if}"
                                   onclick="return ls.favourite.toggle({$oComment->getId()},this,'comment');"
                                   href="#">
                                    {if $oComment->getIsFavourite()}<i class="fa fa-star"></i>{else}<i class="fa fa-star-o"></i>{/if}
                                    <span class="small text-muted favourite-count"
                                          id="fav_count_comment_{$oComment->getId()}">{if $oComment->getCountFavourite() > 0}{$oComment->getCountFavourite()}{/if}</span>
                                </a>
                            </li>
                        {/if}
                        <li class="text-muted  small comment-updated"
                            {if !$oComment->getCommentDateEdit()}style="display: none;" {/if}>
                            &nbsp;{$aLang.comment_updated}:
                            <time datetime="{date_format date=$oComment->getCommentDateEdit() format='c'}">
                                {date_format date=$oComment->getCommentDateEdit() hours_back="12" minutes_back="60" now="60" day="day H:i" format="j F Y, H:i"}
                            </time>
                        </li>
                        {if !$bCommentList}
                            {if $oComment->isDeletable()}
                                {if !$oComment->getDelete()}
                                    <li>&nbsp;<a href="#" class="link link-red-blue link-clear comment-delete"
                                             onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">
                                            &#xf00d;
                                </a></li>
                                {/if}

                                {if $oComment->getDelete()}
                                    <li>&nbsp;<a href="#"
                                             class="comment-repair link link-red-blue link-clear"
                                             onclick="ls.comments.toggle(this,{$oComment->getId()}); return false;">
                                            &#xf01e;
                                </a></li>
                                {/if}
                            {/if}
                            {if $oComment->isEditable()}
                                &nbsp;<a href="#"
                                         class="link link-blue-red link-clear"
                                         onclick="ls.comments.editComment('{$oComment->getId()}', '{$oComment->getTargetType()}', '{$oComment->getTargetId()}'); return false;">
                                <i class="fa fa-pencil"></i>
                            </a>
                            {/if}
                        {/if}
                        {hook run="comment_info" oComment=$oComment}
                    </ul>
                </div>
                <div id="comment_content_id_{$oComment->getId()}" class="comment-text">
                    {if $bCommentList == true}
                        <div class="small text-muted comment-path">
                            <a href="{$oBlog->getUrlFull()}" class="blog-name">{$oBlog->getTitle()|escape:'html'}</a>,&nbsp;
                            <a href="{$oTopic->getUrl()}" class="comment-path-topic">{$oTopic->getTitle()|escape:'html'}</a>
                            <a href="{$oTopic->getUrl()}#comments" class="comment-path-comments">({$oTopic->getCountComment()})</a>
                        </div>
                    {/if}
                    {$oComment->getText()}
                    {if E::IsUser()}
                        {if !$oComment->getDelete() AND $bAllowToComment}
                            <a href="#"
                               onclick="ls.comments.reply({$oComment->getId()}); return false;"
                               class="link link-blue-red link-clear comment-reply">
                                <i class="fa fa-reply"></i>{$aLang.comment_answer}</a>
                        {/if}
                    {/if}

                    {hook run='comment_action' comment=$oComment}
                </div>
                {*{if E::IsUser()}*}
                    {*<ul class="list-unstyled list-inline small comment-actions">*}





                    {*</ul>*}
                {*{/if}*}
            </div>
        {else}
            <span class="text-muted">{$aLang.comment_was_deleted}</span>
        {/if}
        </div>
    </div>
</div>

