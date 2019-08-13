DROP PROCEDURE IF EXISTS getEvntLst;
DELIMITER //
-- ********************************************************************************************
-- getEvntLst イベント一覧を取得する
--
-- 【処理概要】
--  全てのイベントを開催日時順に列挙する
--
--
-- 【呼び出し元画面】
--   エントランス
--
-- 【引数】
--   なし
--
--
-- 【戻り値】
--      exit_cd            : exit_cd
--      正常：0
--      異常：99
-- --------------------------------------------------------------------------------------------
-- 【更新履歴】
--  2019.7.23 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `getEvntLst`(
    OUT `exit_cd` INTEGER
)
COMMENT 'イベントリスト取得'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    set @query = CONCAT("
        SELECT
            CNTNT_CD
            ,PRNT_CNTNT_CD
            ,TTL
            ,STTS_CD
            ,STT_TM
            ,DATE_FORMAT(STT_TM, '%H:%i') as STT_HM
            ,DATE_FORMAT(STT_TM, '%Y%m%d %H:%i') as STT_DTTM
            ,END_TM
            ,DATE_FORMAT(END_TM, '%H:%i') as END_HM
            ,DATE_FORMAT(END_TM, '%Y%m%d %H:%i') as END_DTTM
            ,DATE_FORMAT(GTHR_TM, '%H:%i') as GTHR_HM
            ,CNTNT
            ,RMRKS
        FROM
            T_CNTNT
        ORDER BY STT_TM,END_TM DESC
        ;
    ");

    SET @query_text = @query;

        -- 実行
    PREPARE main_query FROM @query_text;
    EXECUTE main_query;
    DEALLOCATE PREPARE main_query;

    SET exit_cd = 0;

END
//
DELIMITER ;
