"""Foundational contracts shared by BibleGameCard application interfaces."""

from biblegamecard.core.config import ApplicationConfig
from biblegamecard.core.ids import CollectorId
from biblegamecard.core.lifecycle import AssetLifecycle
from biblegamecard.core.paths import RepositoryPaths
from biblegamecard.core.results import Diagnostic, OperationResult, StatusCategory

__all__ = [
    "ApplicationConfig",
    "AssetLifecycle",
    "CollectorId",
    "Diagnostic",
    "OperationResult",
    "RepositoryPaths",
    "StatusCategory",
]
