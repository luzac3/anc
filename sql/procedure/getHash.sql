DROP PROCEDURE IF EXISTS getHash;
DELIMITER //
-- ********************************************************************************************
-- getHash ハッシュコード取得処理
--
-- 【処理概要】
--   ハッシュコードを取得する
--
--
-- 【呼び出し元画面】
--   エントランス
--
-- 【引数】
--   _userName             ：ユーザー名
--   _twitterId            ：ツイッターID
--
--
-- 【戻り値】
--		exit_cd            : exit_cd
--		正常：0
--		異常：99
-- --------------------------------------------------------------------------------------------
-- 【更新履歴】
--  2019.8.15 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `getHash`(
    IN `_userName` CHAR(100)
    , IN `_twitterId` CHAR(50)
    , OUT `exit_cd` INTEGER
)
COMMENT 'ユーザー登録処理'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        SELECT @sqlstate, @errno, @text;
        ROLLBACK;
        SET exit_cd = 99;
    END;

        SET @query = CONCAT("
            SELECT
                USER_ID
                ,HASH
            FROM
                T_USER
            WHERE
                USER_NAME = '",_userName,"'
            AND
                TWITTER_ID = '",_twitterId,"'
            ;
        ")
        ;

    SET @query_text = @query;

    -- 実行
    PREPARE main_query FROM @query_text;
    EXECUTE main_query;
    DEALLOCATE PREPARE main_query;

    SET exit_cd = 0;

END
//
DELIMITER ;
