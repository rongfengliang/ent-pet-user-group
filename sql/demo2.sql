SELECT
    DISTINCT `pets`.`id`,
    `pets`.`name`
FROM
    `pets`
WHERE
    `pets`.`owner_id` IN (
        SELECT
            `id`
        FROM
            `users`
        WHERE
            `users`.`id` IN (
                SELECT
                    `user_friends`.`user_id`
                FROM
                    `user_friends`
                    JOIN `users` AS `t0` ON `user_friends`.`friend_id` = `t0`.`id`
                WHERE
                    `t0`.`id` IN (
                        SELECT
                            `admin_id`
                        FROM
                            `groups`
                        WHERE
                            `admin_id` IS NOT NULL
                    )
            )
    )