DROP PROCEDURE IF EXISTS registerUser;
DELIMITER //
-- ********************************************************************************************
-- registerUser ユーザー登録処理
--
-- 【処理概要】
--   ユーザー情報を登録する
--
--
-- 【呼び出し元画面】
--   アンケート画面
--
-- 【引数】
--   _userId               ：ユーザー番号
--   _userName             ：ユーザー名
--   _twitterId            ：ツイッターID
--   _hash                 ：ハッシュ
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
CREATE PROCEDURE `registerUser`(
    IN `_userId` CHAR(20)
    , IN `_userName` CHAR(100)
    , IN `_twitterId` CHAR(50)
    , IN `_dancePlanFlg` CHAR(1)
    , IN `_hash` CHAR(80)
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
            INSERT INTO
                T_USER
            VALUES(
                '",_userId,"','",_userName,"','",_twitterId,"','",_dancePlanFlg,"','",_hash,"'
            )
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
