<?php
/*---------------------------------------------------------------------------
 * @Project: Alto CMS
 * @Project URI: http://altocms.com
 * @Description: Advanced Community Engine
 * @Copyright: Alto CMS Team
 * @License: GNU GPL v2 & MIT
 *----------------------------------------------------------------------------
 */

F::IncludeFile('./ICacheBackend.php');
F::IncludeFile(LS_DKCACHE_PATH . 'Zend/Cache/Backend/File.php');

/**
 * Class CacheBackendFile
 *
 * Файловый кеш
 */

class CacheBackendFile extends Dklab_Cache_Backend_Profiler implements ICacheBackend {

    static public function init($sFuncStats) {

        $oCache = new Zend_Cache_Backend_File(
            array(
                 'cache_dir'              => Config::Get('sys.cache.dir'),
                 'file_name_prefix'       => Config::Get('sys.cache.prefix'),
                 'read_control_type'      => 'crc32',
                 'hashed_directory_level' => Config::Get('sys.cache.directory_level'),
                 'read_control'           => true,
                 'file_locking'           => true,
            )
        );
        return new self($oCache, $sFuncStats);
    }

    public function IsMultiLoad() {

        return false;
    }

    public function IsAvailable() {
$s=Config::Get('sys.cache.dir');
        return F::File_CheckDir(Config::Get('sys.cache.dir'), true);
    }

    public function IsСoncurrent() {
        return true;
    }

    public function Load($sName, $bNotTestCacheValidity = false) {

        $xData = parent::load($sName, $bNotTestCacheValidity);
        if ($xData && is_string($xData)) {
            return unserialize($xData);
        }
        return $xData;
    }

    public function Save($xData, $sName, $aTags = array(), $nTimeLife = false) {

        return parent::save(serialize($xData), $sName, $aTags, $nTimeLife);
    }

}

// EOF