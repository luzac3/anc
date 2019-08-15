DROP PROCEDURE IF EXISTS washChange;
DELIMITER //
-- ********************************************************************************************
-- washChange 洗替用削除処理
--
-- 【処理概要】
--   洗替用削除処理
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
CREATE PROCEDURE `washChange`(
    IN `_userName` CHAR(100)
    , IN `_twitterId` CHAR(50)
    , OUT `exit_cd` INTEGER
)
COMMENT '洗替用削除処理'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        SELECT @sqlstate, @errno, @text;
        ROLLBACK;
        SET exit_cd = 99;
    END;

      DELETE FROM T_USER_SELECTED_DANCE
      WHERE
          USER_ID = (
              SELECT DISTINCT
                  USER_ID
              FROM
                  T_USER
              WHERE
                  USER_NAME= _userName
              AND
                  TWITTER_ID = _twitterId
          )
      ;

      DELETE FROM T_USER
        WHERE
            USER_NAME = _userName
        AND
            TWITTER_ID = _twitterId
      ;

    SET exit_cd = 0;

END
//
DELIMITER ;
