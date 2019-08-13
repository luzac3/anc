DROP PROCEDURE IF EXISTS newEvnt;
DELIMITER //
-- ********************************************************************************************
-- newEvnt 新規イベントコードを作成する
--
-- 【処理概要】
--  新規のイベントを作成する
--
--
-- 【呼び出し元画面】
--   リスト
--
-- 【引数】
--      なし
--
--
-- 【戻り値】
--      exit_cd            : exit_cd
--      正常：0
--      異常：99
-- --------------------------------------------------------------------------------------------
-- 【更新履歴】
--  2019.7.25 大杉　新規作成
-- ********************************************************************************************
CREATE PROCEDURE `newEvnt`(
    OUT `exit_cd` INTEGER
)
COMMENT '新イベント作成'

BEGIN

    -- 異常終了ハンドラ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION SET exit_cd = 99;

    SELECT
        LPAD(MAX(CAST(CNTNT_CD AS SIGNED)) + 1 ,4 ,0) INTO @NEW_CNTNT_CD
    FROM
        T_CNTNT
    ;

    INSERT INTO
        T_CNTNT
    VALUES(
        @NEW_CNTNT_CD
        ,NULL
        ,""
        ,0
        ,"0000-00-00 00:00:00.000"
        ,"0000-00-00 00:00:00.000"
        ,NULL
        ,""
        ,NULL
    );

    set @query = CONCAT("
        SELECT
            CNTNT_CD
        FROM
            T_CNTNT
        WHERE
            CNTNT_CD = '",@NEW_CNTNT_CD,"'
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
