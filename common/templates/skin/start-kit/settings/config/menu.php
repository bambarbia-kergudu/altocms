<?php

/**
 * Главное меню сайта
 * Настройки берутся из главного конфига меню common/config/menu.php
 */


/**
 *  Вход и регистрация
 */
$config['menu']['data']['login'] = array(
    'list' => array(
        'login'        => array(
            'options' => array(
                'link_class' => 'js-modal-auth-login'
            ),
        ),
        'registration' => array(
            'options' => array(
                'class'      => 'hidden-sm',
                'link_class' => 'js-modal-auth-registration',
            ),
        ),
    )
);

if (E::IsUser()) {
    /**
     *  Меню пользователя
     */
    $config['menu']['data']['user'] = array(
        'list' => array(
            'talk'    => array(
                'text'    => array(
                    '<span class="glyphicon glyphicon-envelope"></span>&nbsp;+',
                    'new_talk' => array(),
                ),
                'options' => array(
                    'link_class' => 'new-messages'
                ),
            ),
            'userbar' => array(
                'text'    => array(
                    'user_name' => array(),
                    '<b class="caret"></b>'
                ),
                'options' => array(
                    'class'       => 'dropdown nav-userbar',
                    'link_class'  => 'dropdown-toggle username',
                    'image_url'   => array('user_avatar_url' => array('32')),
                    'image_title' => array('user_name'),
                    'image_class' => 'avatar',
                    'link_data'   => array(
                        'toggle' => 'dropdown',
                        'target' => '#',
                    ),
                ),
            ),
        )
    );

    /**
     *  Подменю пользователя
     */
    $config['menu']['data']['userbar'] = array(
        'class' => 'dropdown-menu',
        'list'  => array(
            'user'         => array(
                'link' => E::User()->getProfileUrl(),
            ),
            'talk'         => array(
                'text'    => array(
                    '{{user_privat_messages}}',
                    '<span class="new-messages">',
                    'new_talk_string' => array(),
                    '</span>'
                ),
                'options' => array(
                    'link_id'    => 'new_messages',
                    'link_title' => array('new_talk' => array())
                )
            ),
            'wall'         => array(
                'link' => E::User()->getProfileUrl() . 'wall/',
            ),
            'publication'  => array(
                'link' => E::User()->getProfileUrl() . 'created/topics/',
            ),
            'favourites'   => array(
                'link' => E::User()->getProfileUrl() . 'favourites/topics/',
            ),
            'userbar_item' => '',
            'logout'       => array(
                'link' => Router::GetPath('login') . 'exit/?security_key=' . E::Security_GetSecurityKey(),
            ),
        )
    );
}


/**
 *  Меню топиков
 */
$config['menu']['data']['topics'] = array(
    'list' => array(
        'good'                 => array(
            'options' => array(
                'class' => 'bordered',
            )
        ),
        'new'                  => array(
            'text'    => array(
                '{{blog_menu_all_new}} + ',
                'new_topics_count' => array(),
            ),
            'options' => array(
                'class'      => 'bordered',
                'link_title' => '{{blog_menu_top_period_24h}}'
            )
        ),

        'newall'               => array(
            'options' => array(
                'class'      => 'bordered',
                'link_title' => '{{blog_menu_top_period_24h}}'
            )
        ),

        'feed'                 => array(
            'options' => array(
                'class' => 'bordered',
            )
        ),

        'empty'                => array(
            'text' => false,
            'options' => array(
                'class'      => 'divider',
            ),
        ),

        'discussed'            => array(
            'text'    => array(
                '{{blog_menu_all_discussed}}',
                '<b class="caret"></b>',
            ),
            'submenu' => 'discussed',
            'options' => array(
                'class'      => 'dropdown',
                'link_class' => 'dropdown-toggle',
                'link_data'  => array(
                    'toggle' => 'dropdown',
                )
            )
        ),

    )
);

if (C::Get('rating.enabled')) {
    $config['menu']['data']['topics']['list']['top'] = array(
        'text'    => array(
            '{{blog_menu_all_top}}',
            '<b class="caret"></b>',
        ),
        'submenu' => 'top',
        'options' => array(
            'class'      => 'dropdown',
            'link_class' => 'dropdown-toggle',
            'link_data'  => array(
                'toggle' => 'dropdown',
            )
        )
    );
}

/**
 *  Подменю обсуждаемых
 */
$config['menu']['data']['discussed'] = array(
    'class' => 'dropdown-menu',
);

if (C::Get('rating.enabled')) {
    /**
     *  Подменю топовых
     */
    $config['menu']['data']['top'] = array(
        'class' => 'dropdown-menu',
    );
}
