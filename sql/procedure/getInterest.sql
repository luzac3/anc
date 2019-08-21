DROP PROCEDURE IF EXISTS getInterest;
DELIMITER //
-- ********************************************************************************************
-- getInterest 興味あり取得処理
--
-- 【処理概要】
--   興味はあるが振り付けは覚えていない人用の処理
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
--  2019.8.22 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `getInterest`(
      OUT `exit_cd` INTEGER
)
COMMENT '興味あり取得処理'

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
                ,USER_NAME
                ,TWITTER_ID
            FROM
                T_USER
            WHERE
                DANCE_PLAN_FLG = '2'
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
