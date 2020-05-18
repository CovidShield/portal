Rails.application.config.session_store :cookie_store,
                                       key: '_portal_session',
                                       expire_after: 7. days,
                                       secure: true,
                                       same_site: :lax
