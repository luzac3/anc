DROP PROCEDURE IF EXISTS getEvnt;
DELIMITER //
-- ********************************************************************************************
-- getEvnt イベントを取得する
--
-- 【処理概要】
--  コードによりイベントを取得する
--
--
-- 【呼び出し元画面】
--   リスト
--
-- 【引数】
--      input_cntnt_cd     : コンテンツコード
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
CREATE PROCEDURE `getEvnt`(
    IN `input_cntnt_cd` CHAR(4)
    , OUT `exit_cd` INTEGER
)
COMMENT 'イベントリスト取得'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    set @query = CONCAT("
        SELECT
            TC.CNTNT_CD AS CNTNT_CD
            ,TC.PRNT_CNTNT_CD AS PRNT_CNTNT_CD
            ,TC.TTL AS TTL
            ,TC.STTS_CD AS STTS_CD
            ,CSC.STTS AS STTS
            ,TC.STT_TM AS STT_TM
            ,DATE_FORMAT(TC.STT_TM, '%H:%i') as STT_HM
            ,DATE_FORMAT(TC.STT_TM, '%Y%m%d %H:%i') as STT_DTTM
            ,TC.END_TM AS END_TM
            ,DATE_FORMAT(TC.END_TM, '%H:%i') as END_HM
            ,DATE_FORMAT(TC.END_TM, '%Y%m%d %H:%i') as END_DTTM
            ,DATE_FORMAT(TC.GTHR_TM, '%H:%i') as GTHR_HM
            ,TC.CNTNT AS CNTNT
            ,TC.RMRKS AS RMRKS
            ,GROUP_CONCAT(TCJ.JNNR_CD) AS JNNR_CD
            ,TCJ.GTHR_FLG AS GTHR_FLG
            ,GROUP_CONCAT(TJ.JNNR_NM) AS JNNR_NM
        FROM
            T_CNTNT TC
        LEFT OUTER JOIN
            C_STTS_CD CSC
                ON
                    TC.STTS_CD = CSC.STTS_CD
        LEFT OUTER JOIN
            T_CNTNT_JNNR TCJ
                ON
                    TC.CNTNT_CD = TCJ.CNTNT_CD
        LEFT OUTER JOIN
            T_JNNR TJ
                ON
                    TCJ.JNNR_CD = TJ.JNNR_CD
        WHERE
            TC.CNTNT_CD = '",input_cntnt_cd,"'
        GROUP BY
            CNTNT_CD
            ,PRNT_CNTNT_CD
            ,TTL
            ,STTS_CD
            ,STTS
            ,STT_TM
            ,STT_HM
            ,STT_DTTM
            ,END_TM
            ,END_HM
            ,END_DTTM
            ,GTHR_HM
            ,CNTNT
            ,RMRKS
            ,GTHR_FLG
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
